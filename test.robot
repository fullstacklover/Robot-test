*** Settings ***
Library    SeleniumLibrary

Test Setup       Ouverture Navigateur
Test Teardown    Fermer le navigateur

*** Variables ***
${URL}                    https://automationplayground.com/crm/
${VALID_EMAIL}            admin@robotframeworktutorial.com
${VALID_PASSWORD}         pwd
${INVALID_EMAIL}          wrong@example.com
${INVALID_PASSWORD}       wrongpassword

*** Test Cases ***
CAS_1_Email_Valide_Mot_De_Passe_Invalide
    Ouvrir La Page De Login
    Saisir Email    ${VALID_EMAIL}
    Saisir Mot De Passe    ${INVALID_PASSWORD}
    Cliquer Sur Submit
    Verifier Echec Connexion

CAS_2_Email_Invalide_Mot_De_Passe_Valide
    Ouvrir La Page De Login
    Saisir Email    ${INVALID_EMAIL}
    Saisir Mot De Passe    ${VALID_PASSWORD}
    Cliquer Sur Submit
    Verifier Echec Connexion

CAS_3_Email_Valide_Mot_De_Passe_Valide
    Ouvrir La Page De Login
    Saisir Email    ${VALID_EMAIL}
    Saisir Mot De Passe    ${VALID_PASSWORD}
    Cliquer Sur Submit
    Verifier Connexion Reussie

*** Keywords ***
Ouverture Navigateur
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible
    ...    xpath=//a[contains(., 'Sign In')]
    ...    timeout=15s

Ouvrir La Page De Login
    Click Element    xpath=//a[contains(., 'Sign In')]
    Wait Until Element Is Visible    id=email-id    timeout=15s

Saisir Email
    [Arguments]    ${email}
    Input Text    id=email-id    ${email}

Saisir Mot De Passe
    [Arguments]    ${password}
    Input Password    id=password    ${password}

Cliquer Sur Submit
    Click Button    id=submit-id

Verifier Echec Connexion
    Wait Until Location Does Not Contain
    ...    customers.html
    ...    timeout=10s
    Log    La connexion a ete refusee.

Verifier Connexion Reussie
    Wait Until Location Contains    customers.html    timeout=15s
    Log    Connexion reussie.

Fermer le navigateur
    Close Browser