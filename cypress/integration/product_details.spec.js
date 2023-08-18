beforeEach(() => {
  cy.visit("/");
});

it("Clicks the link of a product", () => {
  cy.get(".products article").first().click();

  cy.url().should("include", "/products/2");
});
