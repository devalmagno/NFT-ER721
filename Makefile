-include .env

.PHONY: deployMood mintMoodNft flipMoodNft

DEFAULT_ANVIL_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
DEFAULT_ACCOUNT=default

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account $(DEFAULT_ACCOUNT) --broadcast
endif

deployMood:;	forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

mintMoodNft:;	forge script script/Interactions.s.sol:MintMoodNft $(NETWORK_ARGS)

flipMoodNft:;	forge script script/Interactions.s.sol:FlipMoodNft $(NETWORK_ARGS)