  it('can ping the log on localhost:3001', () => {
    cy.visit('http://localhost:3001')

    cy.get('[data-icon="user"]').click().then(() => {
      cy.get('[id="signInUsername"]').type('Bastien').then(() => {
        cy.get('[id="signInPassword"]').type('azerty').then(() => {
          cy.get('[id="connection"]').click().then(
            () => {
              cy.get('button').contains('Logout').click()
            }
          )
        })
      })
    })
  })
