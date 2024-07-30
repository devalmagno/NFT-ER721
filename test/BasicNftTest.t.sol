// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Test {
    string constant NFT_NAME = "BasicNft";
    string constant NFT_SYMBOL = "BNFT";

    address private constant USER = address(1);
    address private constant OTHER_USER = address(2);

    BasicNft public basicNft;

    function setUp() public {
        basicNft = new BasicNft();
    }

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    modifier mintNft() {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);
        _;
    }

    function testInitializedCorrectly() public view {
        assert(
            keccak256(abi.encodePacked(basicNft.name())) ==
                keccak256(abi.encodePacked(NFT_NAME))
        );
        assert(
            keccak256(abi.encodePacked(basicNft.symbol())) ==
                keccak256(abi.encodePacked(NFT_SYMBOL))
        );
    }

    function testCanMintAndHaveABalance() public mintNft {
        assert(basicNft.balanceOf(USER) == 1);
    }

    function testTokenURIIsCorrect() public mintNft {
        assert(
            keccak256(abi.encodePacked(basicNft.tokenURI(0))) ==
                keccak256(abi.encodePacked(PUG_URI))
        );
    }

    function testTransfers() public mintNft {
        vm.prank(USER);
        basicNft.transferFrom(USER, OTHER_USER, 0);

        assert(basicNft.balanceOf(USER) == 0);
        assert(basicNft.balanceOf(OTHER_USER) == 1);
        assert(basicNft.ownerOf(0) == OTHER_USER);
    }

    function testApproval() public mintNft {
        vm.prank(USER);
        basicNft.approve(OTHER_USER, 0);

        assert(basicNft.getApproved(0) == OTHER_USER);
    }
}
