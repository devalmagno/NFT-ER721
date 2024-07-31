// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvg = vm.readFile("./images/dynamicNft/happy.svg");
        string memory sadSvg = vm.readFile("./images/dynamicNft/sad.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(happySvg, sadSvg);
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageUri(
        string memory _svg
    ) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(_svg)))
        );

        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
