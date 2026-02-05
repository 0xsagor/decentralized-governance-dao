# Decentralized Governance DAO

This repository contains the core logic for a Decentralized Autonomous Organization (DAO). It allows token holders to participate in the decision-making process of a protocol through a transparent, on-chain voting mechanism.

## Features
- **Proposal Lifecycle**: Create, vote, and execute proposals entirely on-chain.
- **Weighted Voting**: Voting power is directly proportional to the number of governance tokens held by a member.
- **Quorum & Thresholds**: Customizable requirements for proposal success.
- **Security**: Built-in checks to prevent double-voting and unauthorized execution.

## Governance Logic
A proposal is considered "Passed" if it meets two mathematical conditions:
1. **Quorum**: The total votes ($V_{total}$) must exceed the minimum required percentage ($Q$) of the total supply ($S$):
   $$V_{total} > S \times Q$$
2. **Majority**: The "Yes" votes ($V_y$) must be greater than the "No" votes ($V_n$):
   $$V_y > V_n$$

## License
MIT
