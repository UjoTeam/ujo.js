pragma solidity ^0.5.0;

/*
This re-adds badges that were minted in:
https://etherscan.io/address/0xc45e027f0f9d7e90e612be02d4e710a632a9dba9
*/

// solhint-disable
contract InitBadges {
    function initialise() public {
        address[] memory beneficiaries = new address[](1);
        uint256[] memory splits = new uint256[](1);
        splits[0] = 100;
        // function adminMintWithoutPayment(address _buyer, string _nftCid, address[] _beneficiaries, uint256[] _splits, uint256 _usdCost)
        beneficiaries[0] = address(0x48c856F10d5930DaE3CF338173247aB8DA94d308);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x497e90a0414e1f07cD39416D09F27DC62098bc14, "zdpuAoKFJ5jGSiGCjLBNCA3QjSWwMT5PrWar5X2F69E2auEmU", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x804A981c929C133cfC95e0094495325F5D84Fdd3);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0xAAA8a090E78724c8E3f3dE407205fff160017568, "zdpuAtEcodozzUGvSdZaqYKE8PdoWxGdqMHHyVEsAeDos6nvo", beneficiaries, splits, 5));
        beneficiaries[0] = address(0xd1C2388c9B40a1c1D4340924b8cc8dC9876499b4);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0xAAA8a090E78724c8E3f3dE407205fff160017568, "zdpuAyn6PQhfXVbk8vjVuLfinUQscxyn8JNdEJrSyeAw7kDDn", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x66bE39D22b9E7177096Db4C96aeE4106E44D4910);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0xAAA8a090E78724c8E3f3dE407205fff160017568, "zdpuAvrUFv5qSzFwTj1GDro38kSjV4TzMjKQk4BpydpR8hycc", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x6c0a787BBAB04F9882e88adD5bdF5d04C9aa650A);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x6c0a787BBAB04F9882e88adD5bdF5d04C9aa650A, "zdpuB2DeEAJeeQNfQK9j5ULqEz238L3LBGQpJc13vQZpTAtWW", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x76bc4C780Dd85558Bc4B24a4f262f4eB0bE78ca7);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x9Fd5cc5E68796f08EDC54e738585227AD2B6c03F, "zdpuAxdXWsSgNwP83bPVbkavCoWTiGtzXZDNexVQ4GWMPCxhP", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x2ABfE45394Df8dCEA4BC8006bab2cc5A850a9305);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x1318d3420b0169522eB8F3EF0830aceE700A2eda, "zdpuAm4tRL89dSSF2Vta6AAyjXKyhyV49wqPxqmswfM1fnosm", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x2ABfE45394Df8dCEA4BC8006bab2cc5A850a9305);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x07A93218F692e18Dd77D693D84568A5042df667b, "zdpuAm4tRL89dSSF2Vta6AAyjXKyhyV49wqPxqmswfM1fnosm", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x1875e398cD7FdcE8fF5C9d4ce1Ec904caE51692c);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x9e56625509c2F60aF937F23B7b532600390e8C8B, "zdpuAvxg3YbgQvMCnyJAXpnHxD8bnip2ZXsra2pYVJJ9cRsXR", beneficiaries, splits, 5));
        beneficiaries[0] = address(0xeDD17DB41eE47B8794b10802aC05806a66f3ab36);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x374Bd185Ee19fD9f8682Eb875E5D0546A8D58CdD, "zdpuApfb2CNwsqLp8WESfsgcH17tVGrS3H3EHD3fnhBqahWjZ", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x84Aa1925A0AfB812Ec4373E321E0b9B82f64574d);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x258DDD84abf61ba1D1E39f95D8863ee9ca218c06, "zdpuAudtSK7X7uJkMjDTWzJWMHdynHo11Eb6W2PicgVh5LgfU", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x6e4125Dd92515AA29Efd24C8bBf09D17DD92F74b);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0xd797D5784f43dE300eC0D6bc34fc86023c5d71Ce, "zdpuAmcXTEYmkRwLMejbEBzBNqnwEuJaU9eXAWLRUdnwgFqPv", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x84Aa1925A0AfB812Ec4373E321E0b9B82f64574d);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x374Bd185Ee19fD9f8682Eb875E5D0546A8D58CdD, "zdpuAudtSK7X7uJkMjDTWzJWMHdynHo11Eb6W2PicgVh5LgfU", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x374Bd185Ee19fD9f8682Eb875E5D0546A8D58CdD);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x3ece8d40daC89FfB408f7CB5eaf24Ab6A3135028, "zdpuAxiK3125eK82n4Rcx6w7rm87skCvsU4FvNooBavw8JwZY", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x374Bd185Ee19fD9f8682Eb875E5D0546A8D58CdD);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x2A3F7E5170Ea8Ca967f85f091eF84591f639E031, "zdpuAxiK3125eK82n4Rcx6w7rm87skCvsU4FvNooBavw8JwZY", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x35A7e40871A621d138e6E7e565Ea23b90e333494);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x35A7e40871A621d138e6E7e565Ea23b90e333494, "zdpuB3eE6U8XtsRuj5jU8r7GuE4XXD1oART7HgQAAjSN8eDoU", beneficiaries, splits, 5));
        beneficiaries[0] = address(0xc8F4652CdBE54ee3A048B58fFC59B72E4298Fc84);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x374Bd185Ee19fD9f8682Eb875E5D0546A8D58CdD, "zdpuB1iMrcPAdWnWpchxD5hi8ErUtJzymHsLYnyktSqLJyBhE", beneficiaries, splits, 5));
        beneficiaries[0] = address(0x1875e398cD7FdcE8fF5C9d4ce1Ec904caE51692c);address(this).delegatecall(abi.encodeWithSignature("adminMintWithoutPayment(address,string,address[],uint256[],uint256)", 0x374Bd185Ee19fD9f8682Eb875E5D0546A8D58CdD, "zdpuAvxg3YbgQvMCnyJAXpnHxD8bnip2ZXsra2pYVJJ9cRsXR", beneficiaries, splits, 5));
    }
}