// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenTransfer {
    struct Transfer {
        address from;
        address to;
        uint256 amount;
        bool devolucion;
    }

    mapping(bytes32 => Transfer) public transfers;

    event TransferInitiated(
        bytes32 indexed transferId,
        address indexed from,
        address indexed to,
        uint256 amount
    );

    function initiateTransfer(address token, address to, uint256 amount) external {
        require(to != address(0), "Invalid recipient");
        require(amount > 0, "Amount must be greater than zero");

        IERC20 erc20Token = IERC20(token);
        require(erc20Token.transferFrom(msg.sender, to, amount), "Transfer failed");

        bytes32 transferId = keccak256(abi.encodePacked(msg.sender, to, amount, block.timestamp));
        transfers[transferId] = Transfer({
            from: msg.sender,
            to: to,
            amount: amount,
            devolucion: false
        });

        emit TransferInitiated(transferId, msg.sender, to, amount);
    }

    function getTransferDetails(bytes32 transferId) external view returns (address, address, uint256, bool) {
        Transfer memory transfer = transfers[transferId];
        return (transfer.from, transfer.to, transfer.amount, transfer.devolucion);
    }

    function markAsReturned(bytes32 transferId) external {
        Transfer storage transfer = transfers[transferId];
        require(transfer.to == msg.sender, "Only the recipient can mark as returned");
        require(!transfer.devolucion, "Already marked as returned");

        transfer.devolucion = true;

        // Return tokens to the original sender
        IERC20 erc20Token = IERC20(msg.sender);
        require(erc20Token.transfer(transfer.from, transfer.amount), "Return transfer failed");
    }
}
