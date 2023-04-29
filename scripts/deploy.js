async function main() {
	const [deployer] = await ethers.getSigners();

	console.log("Deploying contracts with the account:", deployer.address);

	console.log("Account balance:", (await deployer.getBalance()).toString());

	const L00kinCitizenID = await ethers.getContractFactory("L00kinCitizenID");
	const l00kinCitizenIDContract = await L00kinCitizenID.deploy();
	console.log("L00kinCitizenID contract address:", l00kinCitizenIDContract.address);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});