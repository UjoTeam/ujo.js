pragma solidity ^0.5.0;
import "./utils/SafeMath.sol";
import "./utils/strings.sol";
import "./IUSDETHOracle.sol";
import "./eip721/EIP721.sol";


contract ProxyState {

    address public owner;
    address internal delegate;

    /* NOTE:
    - A brief explanation on how this works and why this is necessary.
    - Storage is allocated sequentially in Solidity.
    - Variables names essentially map to a position in storage.
    - In using delegatecall, it executes the code in the context of the calling contract.
    - Thus, it will be dereferenced to point to some storage slot based on its position of declaration.
    - So, if the calling contract has a variable "owner" and the and the called contract
    also has a variable "owner", it doesn't mean it will point to the same storage slot.
    - It will only point to the same storage slot IF, and only IF, the variable "owner"
    was declared in the same position.
    - In this case, the proxy itself has two allocated storage slots: 1) owner & 2) delegate.
    - Thus, any contract that is delegatecalled should ONLY be referencing storage *after*
    the first two declarations.
    - If you want to use the variables in the proxy's state, the variable declarations doesn't
    have to be the same, but it helps to read better if they are.
    - Order matters.
    - Thus, reading the functions contract: it is proxy vars, then EIP721 vars, then its own.
    - When the called contract is executed, then it will execute on the calling contract state.
    - This contract can be interacted on its without being delegated towards, writing to its own storage.
    - Nothing about writing to its own storage is detrimental to the function of the proxy [unlikely
    the Parity Wallet hack where the contract could self-destruct].
    */
}


// solhint-disable max-states-count
contract UjoPatronageBadgesFunctions is ProxyState, EIP721 {
    using SafeMath for uint256;
    using strings for *;

    string public tokenURIBase;
    string public tokenURISuffix;
    mapping (uint256 => string) public tokenURIIDs;

    uint256 public totalMinted = 0;

    IUSDETHOracle public oracle;

    bool internal setup = false;

    modifier onlyProxyOwner() {
        require(msg.sender == owner);
        _;
    }

    event LogBadgeMinted(uint256 indexed tokenId, string nftcid, uint256 timeMinted, address buyer, address issuer);
    event LogPaymentProcessed(uint256 indexed tokenId, address payable[] beneficiaries, uint256[] splits, uint256 usdCostOfBadge);

    // overload inherited tokenURI
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        return tokenURIBase.toSlice().concat(tokenURIIDs[_tokenId].toSlice()).toSlice().concat(tokenURISuffix.toSlice());
    }

    function setupBadges(address _initialiseBadges, address _initialOracle) public onlyProxyOwner {
        require(!setup);
        name = "Patronage Badges";
        symbol = "PATRON";
        tokenURIBase = "https://ipfs.infura.io:5001/api/v0/dag/get?arg=";
        tokenURISuffix = "";
        oracle = IUSDETHOracle(_initialOracle);
        // this issues a delegatecall in case there needs to be an initial setup the badges.
        // eg, creating 100 initial badges for example.
        _initialiseBadges.delegatecall(abi.encodeWithSignature("initialise()")); // solhint-disable-line avoid-low-level-calls
        setup = true;
    }

    // additional helper function not in EIP721.
    function getAllTokens(address _owner) public view returns (uint256[] memory) {
        uint size = ownedTokens[_owner].length;
        uint[] memory result = new uint256[](size);
        for (uint i = 0; i < size; i++) {
            result[i] = ownedTokens[_owner][i];
        }
        return result;
    }
    /* function testGetDelegate() public view returns(address) {
        return delegate;
    } */

    function setOracle(address _oracle) public onlyProxyOwner {
        oracle = IUSDETHOracle(_oracle);
    }

    // URI is the CID
    // solhint-disable-next-line func-param-name-mixedcase
    function setTokenURIID(uint256 _tokenID, string memory _newID) public onlyProxyOwner tokenExists(_tokenID) {
        tokenURIIDs[_tokenID] = _newID;
    }

    function setTokenURIBase(string memory _newURIBase) public onlyProxyOwner {
        tokenURIBase = _newURIBase;
    }

    function setTokenURISuffix(string memory _newURISuffix) public onlyProxyOwner {
        tokenURISuffix = _newURISuffix;
    }

    /* in the unlikely event that a badge needs to be minted but not paid for */
    function adminMintWithoutPayment(address _buyer, string memory _nftCid, address payable[] memory _beneficiaries, uint256[] memory _splits, uint256 _usdCost) public onlyProxyOwner returns (uint256 tokenId) {
        tokenId = createBadge(_buyer, _nftCid);

        // there's no payment, but log as if it occurred.
        emit LogPaymentProcessed(tokenId, _beneficiaries, _splits, _usdCost);
    }

    function mint(address _buyer, string memory _nftCid, address payable[] memory _beneficiaries, uint256[] memory _splits, uint256 _usdCost) public payable returns (uint256 tokenId) {
        tokenId = createBadge(_buyer, _nftCid);
        processETHPayment(tokenId, _beneficiaries, _splits, _usdCost);
        // note: tokenId is automatically returned due to naming.
    }

    function burnToken(uint256 _tokenId) public allowedToOperate(_tokenId) {
        removeToken(msg.sender, _tokenId);
        emit Transfer(msg.sender, address(0), _tokenId);
    }

    /* internal functions */
    function processETHPayment(uint256 _tokenId, address payable[] memory _beneficiaries, uint256[] memory _splits, uint256 _usdCost) internal {
        uint256 exchangeRate = oracle.getUintPrice();

        require(exchangeRate > 0);
        require(_usdCost > 0);

        // note: division is not done with SafeMath because 1 ether in Solidity is int_const
        // also: divs impossible to over/underflow
        uint256 totalWei = (1 ether / exchangeRate).mul(_usdCost);
        require(msg.value >= totalWei);

        //  Send back remainder.
        if (msg.value > totalWei) {
            msg.sender.transfer(msg.value - totalWei);
        }

        // transfer funds
        if (_beneficiaries.length > 1) {
            processETHMultiplePayments(_beneficiaries, _splits, totalWei);
        } else {
            proccessETHSinglePayment(_beneficiaries[0], totalWei);
        }

        emit LogPaymentProcessed(_tokenId, _beneficiaries, _splits, _usdCost);
    }

    function proccessETHSinglePayment(address payable _beneficiary, uint256 _totalWei) internal {
        _beneficiary.transfer(_totalWei);
    }

    function processETHMultiplePayments(address payable[] memory _beneficiaries, uint256[] memory _splits, uint256 _totalWei) internal {
        require(_beneficiaries.length == _splits.length);

        // note: allowing a split to be zero.

        uint256 totalSplits = 0;
        for (uint256 i = 0; i < _beneficiaries.length; i += 1) {
            _beneficiaries[i].transfer(_splits[i].mul(_totalWei).div(100));
            totalSplits = totalSplits.add(_splits[i]);
        }

        require(totalSplits == 100);
    }

    function createBadge(address _buyer, string memory _nftCid) internal returns (uint256) {
        totalMinted = totalMinted.add(1); // basically impossible to overflow, but still keeping SafeMath.
        uint256 tokenId = totalMinted; // start IDs at 1, since returning 0 could be confusing.
        tokenURIIDs[tokenId] = _nftCid;

        addToken(_buyer, tokenId);
        emit LogBadgeMinted(tokenId, _nftCid, now, _buyer, msg.sender); // solhint-disable-line not-rely-on-time
        return tokenId;
    }
}