import {AddressZero, setupFixture,} from "../helpers/utils";
import {expect} from "chai";

describe("Vault", async () => {
    let vault;
    beforeEach(async () => {
        let fixture = await setupFixture();
        vault = fixture.vault;
    })
    it("Vault.func => setMaxLeverage", async () => {
        const v = vault;
        expect(v.address).not.eq(AddressZero);
        console.log(`${await v.getAmount()}`);
        console.log(`${await v.getUnlockTime()}`);

        await v.setFeeAddress(AddressZero);
    });
});

