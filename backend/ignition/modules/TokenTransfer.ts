import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

// Define the module for deploying the TokenTransfer contract
const TokenTransferModule = buildModule("TokenTransferModule", (m) => {
  // Define the parameters that can be passed during deployment
  const tokenAddress = m.getParameter("tokenAddress", "0xYourTokenAddressHere"); // Replace with your token address
  const recipientAddress = m.getParameter(
    "recipientAddress",
    "0xRecipientAddressHere"
  ); // Replace with recipient address
  const transferAmount = m.getParameter("transferAmount", 1000); // Replace with the amount to transfer

  // Deploy the TokenTransfer contract
  const tokenTransfer = m.contract("TokenTransfer");

  // Call initiateTransfer function after deployment
  m.call(tokenTransfer, "initiateTransfer", [tokenAddress, recipientAddress, transferAmount]);

  // Return the deployed contract instance
  return { tokenTransfer };
});

// Export the TokenTransferModule to be used for deployment
export default TokenTransferModule;
