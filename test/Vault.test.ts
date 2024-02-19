import {AddressZero, setupFixture,} from "../helpers/utils";
import {expect} from "chai";
import {parseEther} from "ethers/lib/utils";

describe("Vault", async () => {
    let vault, ethx, owner;
    beforeEach(async () => {
        let fixture = await setupFixture();
        owner = fixture.owner;
        ethx = fixture.ethx;
    });

    it("check ETHX.FUNC", async () => {
        const e = ethx;
        expect(e.address).not.eq(AddressZero);
        await e.initialize(owner.address);
        await expect(e.initialize(owner.address)).to.be.reverted;

        await expect(e.mint(owner.address, parseEther("1000"))).to.be.reverted;
        await e.grantRole(await e.MINTER_ROLE(), owner.address);
        await e.mint(owner.address, parseEther("1000"));
        expect(await e.balanceOf(owner.address)).eq(parseEther("1000"));

        await expect(e.burnFrom(owner.address, parseEther("100"))).to.be.reverted;
        await e.grantRole(await e.BURNER_ROLE(), owner.address);
        await e.burnFrom(owner.address, parseEther("100"));
    });
});

