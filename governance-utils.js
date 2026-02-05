/**
 * Utility functions for interacting with the DAO Governance contract.
 */

const calculateVotingPower = (balance, totalSupply) => {
    if (totalSupply === 0) return 0;
    return (balance / totalSupply) * 100;
};

const isProposalActive = (deadline) => {
    const currentTime = Math.floor(Date.now() / 1000);
    return currentTime < deadline;
};

module.exports = {
    calculateVotingPower,
    isProposalActive
};
