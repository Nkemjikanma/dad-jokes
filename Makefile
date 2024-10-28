-include .env  # load enviroment variables
.PHONY: build deploy-anvil deploy-sepolia


build:
	forge build

# Remove modules
nuke :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

deploy-sepolia:
	forge script script/DeployDadJokes.s.sol:DeployDadJokes --rpc-url $(SEPOLIA_RPC_URL) --private-key $(DEV_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
