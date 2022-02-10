Atlantis Protocol
=================

Atlantis Loans is a decentralized non-custodial money market protocol where users can participate by borrowing or lending money through the protocol directly from Avalanche, BSC and Polygon. The Atlantis Loans protocol is autonomous and algorithmic with its parameters being controlled by governance proposals and yield curves.


Before getting started with this repo, please read:

* The [Atlantis Whitepaper](https://atlantis.loans/assets/whitepaper.pdf), describing how Atlantis works
* The [Medium Articles](https://medium.com/@atlantisfinance), for getting up to date with the latest protocol news

For questions about interacting with Atlantis, please visit [Telegram](https://t.me/AtlantisLoans).

For security concerns, please email [security@atlantis.loans](mailto:security@atlantis.loans).

Contributing
============

Contributing to the Atlantis protocol is a bit different than most open-source projects -- check out the [Atlantis contribution guidelines](docs/CONTRIBUTING.md) and [Atlantis pull request template](.github/pull_request_template.md)

Contracts
=========

We detail a few of the core contracts in the Atlantis protocol.

<dl>
  <dt>AToken</dt>
  <dd>The Atlantis aTokens, which are self-contained borrowing and lending contracts. Each AToken is assigned an interest rate and risk model (see InterestRateModel and Comptroller sections), and allows accounts to *mint* (supply capital), *redeem* (withdraw capital), *borrow* and *repay a borrow*. Each AToken is an ERC-20 compliant token where balances represent ownership of the market.</dd>
</dl>

<dl>
  <dt>Comptroller</dt>
  <dd>The risk model contract, which validates permissible user actions and disallows actions if they do not fit certain risk parameters. For instance, the Comptroller enforces that each borrowing user must maintain a sufficient collateral balance across all aTokens.</dd>
</dl>

<dl>
  <dt>Atlantis</dt>
  <dd>The Atlantis Governance Token (ATL). Holders of this token have the ability to govern the protocol via the governor contract.</dd>
</dl>

<dl>
  <dt>Governor Alpha</dt>
  <dd>The administrator of the Atlantis timelock contract. Holders of Atlantis token may create and vote on proposals which will be queued into the Atlantis timelock and then have effects on Atlantis aToken and Comptroller contracts. This contract may be replaced in the future with a beta version.</dd>
</dl>

<dl>
  <dt>InterestRateModel</dt>
  <dd>Contracts which define interest rate models. These models algorithmically determine interest rates based on the current utilization of a given market (that is, how much of the supplied assets are liquid versus borrowed).</dd>
</dl>

<dl>
  <dt>Careful Math</dt>
  <dd>Library for safe math operations.</dd>
</dl>

<dl>
  <dt>ErrorReporter</dt>
  <dd>Library for tracking error codes and failure conditions.</dd>
</dl>

<dl>
  <dt>Exponential</dt>
  <dd>Library for handling fixed-point decimal numbers.</dd>
</dl>

<dl>
  <dt>SafeToken</dt>
  <dd>Library for safely handling Erc20 interaction.</dd>
</dl>


Installation
For installing or testing the smart congracts please refer to the [Atlantis BSC repository](https://github.com/atlantis-loans/atlantis-protocol-bsc)

Discussion
----------

For any concerns with the protocol, open an issue or visit us on [Telegram](https://t.me/AtlantisLoans) to discuss.

For security concerns, please email [security@atlantis.loans](mailto:security@atlantis.loans).

_© Copyright 2020, Atlantis Loans
