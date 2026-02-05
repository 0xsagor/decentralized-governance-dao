// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IGovernanceToken.sol";

contract GovernanceDAO {
    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 deadline;
        bool executed;
    }

    IGovernanceToken public token;
    uint256 public proposalCount;
    uint256 public constant VOTING_DURATION = 3 days;

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    constructor(address _tokenAddress) {
        token = IGovernanceToken(_tokenAddress);
    }

    function createProposal(string memory _description) external {
        require(token.balanceOf(msg.sender) > 0, "Must hold tokens to propose");
        
        proposalCount++;
        proposals[proposalCount] = Proposal({
            id: proposalCount,
            proposer: msg.sender,
            description: _description,
            votesFor: 0,
            votesAgainst: 0,
            deadline: block.timestamp + VOTING_DURATION,
            executed: false
        });
    }

    function vote(uint256 _proposalId, bool _support) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.deadline, "Voting expired");
        require(!hasVoted[_proposalId][msg.sender], "Already voted");

        uint256 weight = token.balanceOf(msg.sender);
        require(weight > 0, "No voting power");

        if (_support) {
            proposal.votesFor += weight;
        } else {
            proposal.votesAgainst += weight;
        }

        hasVoted[_proposalId][msg.sender] = true;
    }

    function executeProposal(uint256 _proposalId) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp >= proposal.deadline, "Voting still active");
        require(proposal.votesFor > proposal.votesAgainst, "Proposal rejected");
        require(!proposal.executed, "Already executed");

        proposal.executed = true;
        // Logic for execution (e.g., treasury transfer) would go here
    }
}
