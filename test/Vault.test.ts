import {AddressZero, setupFixture,} from "../helpers/utils";
import {expect} from "chai";
import {parseEther} from "ethers/lib/utils";

describe("Vault", async () => {
    let vault, ethx, auction, orc, penalty, owner,user0;
    beforeEach(async () => {
        let fixture = await setupFixture();
        owner = fixture.owner;
        user0 = fixture.user0;

        ethx = fixture.ethx;
        auction = fixture.auction;
        orc = fixture.orc;
        penalty = fixture.penalty;
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

    it("check auction.func", async() => {
        const a = auction;
        await a.initialize(owner.address, ethx.address);
        await expect(a.initialize(owner.address, ethx.address)).to.be.reverted;
        await a.createLot(parseEther("100"));

        await expect(a.connect(user0).updateStaderConfig(user0.address)).to.be.reverted;
        await expect(a.updateStaderConfig(user0.address)).to.be.ok;

        await expect(a.connect(user0).updateDuration(100)).to.be.reverted;
        await expect(a.updateDuration(100)).to.be.ok;

        await expect(a.connect(user0).updateBidIncrement(123)).to.be.reverted;
        await expect(a.updateBidIncrement(123)).to.be.ok;

        await a.addBid(0, {value: parseEther("0.001")});
        await a.addBid(1, {value: parseEther("0.001")});
        await a.addBid(2, {value: parseEther("0.001")});
    });

    it("check ORC.func", async() => {
        const o = orc;
        await o.initialize(owner.address, ethx.address);

        await expect(o.initialize(owner.address, ethx.address)).to.be.reverted;

        await o.depositFor(owner.address, {value: parseEther("0.001")});
        await o.claim();

        await expect(o.connect(user0).updateStaderConfig(ethx.address)).to.be.reverted;
        await expect(o.updateStaderConfig(ethx.address)).to.be.ok;
    });

    it("check Penalty.func", async() => {
        const p = penalty;

        await p.initialize(owner.address, ethx.address, ethx.address);
        await expect(p.initialize(owner.address, ethx.address, ethx.address)).to.be.reverted;

        await p.grantRole(await p.MANAGER_ROLE(), owner.address);
        await p.updateMEVTheftPenaltyPerStrike(0);
        await expect(p.connect(user0).updateMEVTheftPenaltyPerStrike(0)).to.be.reverted;

        await p.updateMissedAttestationPenaltyPerStrike(0);
        await expect(p.connect(user0).updateMissedAttestationPenaltyPerStrike(0)).to.be.reverted;

        await p.updateValidatorExitPenaltyThreshold(0);
        await expect(p.connect(user0).updateValidatorExitPenaltyThreshold(0)).to.be.reverted;

        await p.updateRatedOracleAddress(owner.address);
        await expect(p.connect(user0).updateRatedOracleAddress(owner.address)).to.be.reverted;
        await expect(p.updateRatedOracleAddress(AddressZero)).to.be.reverted;

        await p.updateStaderConfig(owner.address);
        await expect(p.connect(user0).updateStaderConfig(owner.address)).to.be.reverted;
        await expect(p.updateStaderConfig(AddressZero)).to.be.reverted;

        const pubkey = "0x123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0";
        await expect(
            p.calculateMissedAttestationPenalty(pubkey))
            .to.be.reverted;

        await expect(p.getAdditionalPenaltyAmount(pubkey)).to.be.reverted;
    });
});

