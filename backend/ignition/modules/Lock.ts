import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

// Define a constant for a timestamp representing January 1st, 2030
const JAN_1ST_2030 = 1893456000; // https://www.unixtimestamp.com

// Define a constant for 1 Gwei in bigint format (used for locking Ether)
const ONE_GWEI: bigint = 1_000_000_000n; // 1 Gwei in wei

// Define the module for deploying the Lock contract
const LockModule = buildModule("LockModule", (m) => {
  // Retrieve or set the unlock time parameter with a default value of January 1st, 2030
  const unlockTime = m.getParameter("unlockTime", JAN_1ST_2030);
  
  // Retrieve or set the locked amount parameter with a default value of 1 Gwei
  const lockedAmount = m.getParameter("lockedAmount", ONE_GWEI);

  // Deploy the Lock contract with the specified unlock time and locked amount
  const lock = m.contract("Lock", [unlockTime], {
    value: lockedAmount,
  });

  // Return the deployed contract instance
  return { lock };
});

// Export the LockModule to be used for deployment
export default LockModule;
