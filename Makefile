-include .env # load enviroment variables
.PHONY: build deploy-anvil deploy-sepolia


build:
	forge build

deploy-sepolia:
	forge script script/DeployDadJokes.s.sol:DeployDadJokes --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
