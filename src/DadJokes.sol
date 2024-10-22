// SPDX-License_Identifier: MIT

pragma solidity ^0.8.26;

abstract contract DadJokesConstants {
    uint256 public constant BLEH_JOKE = 0.001 ether;
    uint256 public constant DECENT_JOKE = 0.005 ether;
    uint256 public constant PREMIUM_JOKE = 0.01 ether;
}

contract DadJokes is DadJokesConstants {
    /*Errors*/
    error DadJokes__InvalidJokeIndex();
    error DadJokes__InvalidRewardType();
    error DadJokes__DeletedJoke();
    error DadJokes__InvalidRewardAmount();
    error DadJokes__OnlyCreatorCanPerformThisAction();
    error DadJokes__NoBalanceToWithdraw();
    error DadJokes__FailedToWithdraw();

    struct Joke {
        string setup;
        string punchline;
        address creator;
        bool isDeleted;
    }

    // map a joke id to a joke
    mapping(uint256 => Joke) public jokes;
    uint256 private jokeCount; // keep track of the number of jokes

    mapping(address => uint256) public creatorBalances; // keep tract of the creator's balance

    // reward number to reward amount mapping
    mapping(uint8 => uint256) private rewardAmounts;

    /*Events*/
    event JokeAdded(uint256 indexed jokeId, address indexed creator); //
    event JokeRewarded(uint256 indexed jokeId, uint8 rewardType, uint256 rewardAmount);
    event JokeDeleted(uint256 indexed jokeId);
    event BalanceWithdrawn(address indexed creator, uint256 amount);

    constructor() {
        rewardAmounts[1] = BLEH_JOKE;
        rewardAmounts[2] = DECENT_JOKE;
        rewardAmounts[3] = PREMIUM_JOKE;
    }

    function addJoke(string memory _setup, string memory _punchline) public {
        jokes[jokeCount] = Joke(_setup, _punchline, msg.sender, false);
        emit JokeAdded(jokeCount, msg.sender);
        jokeCount++;
    }

    function getJokes() public view returns (Joke[] memory) {
        Joke[] memory allJokes = new Joke[](jokeCount);
        uint256 counter = 0;

        // get all jokes into allJokes array
        for (uint256 i = 0; i < jokeCount; i++) {
            // check if joke is deleted
            if (!jokes[i].isDeleted) {
                allJokes[counter] = jokes[i];
                counter++;
            }
        }

        if (counter == jokeCount) {
            return allJokes;
        } else {
            // create a new array with only the non-deleted jokes
            Joke[] memory filteredJokes = new Joke[](counter);
            for (uint256 i = 0; i < counter; i++) {
                filteredJokes[i] = allJokes[i];
            }

            return filteredJokes;
        }
    }

    function rewardJoke(uint256 jokeId, uint8 _rewardType) public payable {
        if (jokeId > jokeCount) {
            revert DadJokes__InvalidJokeIndex();
        }

        if (_rewardType < 1 || _rewardType > 3) {
            revert DadJokes__InvalidRewardType();
        }

        if (jokes[jokeId].isDeleted) {
            revert DadJokes__DeletedJoke();
        }

        uint256 rewardAmount = rewardAmounts[_rewardType];

        if (msg.value != rewardAmount) {
            revert DadJokes__InvalidRewardAmount();
        }

        creatorBalances[jokes[jokeId].creator] += rewardAmount;
        emit JokeRewarded(jokeId, _rewardType, rewardAmount);
    }

    function deleteJokes(uint256 jokeId) public {
        if (jokeId > jokeCount) {
            revert DadJokes__InvalidJokeIndex();
        }

        if (msg.sender != jokes[jokeId].creator) {
            revert DadJokes__OnlyCreatorCanPerformThisAction();
        }

        if (jokes[jokeId].isDeleted) {
            revert DadJokes__DeletedJoke();
        }

        jokes[jokeId] = Joke("", "", address(0), true); // set joke to deleted

        emit JokeDeleted(jokeId);
    }

    function withdrawBalance() public {
        uint256 balance = creatorBalances[msg.sender];

        if (balance == 0) {
            revert DadJokes__NoBalanceToWithdraw();
        }

        // prevent reentrancy by settings the balance to 0 first
        creatorBalances[msg.sender] = 0;

        // use call to send the balance to the creator/caller
        (bool success,) = payable(msg.sender).call{value: balance}("");

        if (!success) {
            revert DadJokes__FailedToWithdraw();
        }

        emit BalanceWithdrawn(msg.sender, balance);
    }
}
