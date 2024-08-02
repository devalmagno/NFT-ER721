// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string
            memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjUwMCIgIGhlaWdodD0iNTAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjx0ZXh0IHg9IjAiIHk9IjE1IiBmaWxsPSJibGFjayI+SGVsbG8gV29ybGQhPC90ZXh0Pjwvc3ZnPg==";
        string
            memory svg = '<svg viewBox="0 0 200 200" width="500"  height="500" xmlns="http://www.w3.org/2000/svg"><text x="0" y="15" fill="black">Hello World!</text></svg>';
        string memory actualURI = deployer.svgToImageUri(svg);

        assertEq(
            keccak256(abi.encodePacked(expectedURI)),
            keccak256(abi.encodePacked(actualURI))
        );
    }
}
