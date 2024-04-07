/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Your Name
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
    //  The body of the method
    List<Lead> allLeads = [SELECT Id, LastName, Company, Phone, Email 
                           FROM Lead];
    return allLeads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName () {
    //  The body of the method
    List<Contact> contacts = [SELECT Id, FirstName, Name 
                               FROM Contact 
                               WHERE FirstName = 'John'];
    return contacts;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName () {
    //  The body of the method 
    List<Id> contactIds = new List<Id>();
        for (Contact c : [SELECT Id 
                           FROM Contact 
                           WHERE LastName = 'Smith' OR LastName = 'Jones']) {
            contactIds.add(c.Id);
        }
    return contactIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getCWOppsbyAccount (Id accountId) {
    //  The body of the method
    List<Opportunity> cwOpps = [SELECT Id, Name, StageName, CloseDate, Amount, AccountId
                                 FROM Opportunity 
                                 WHERE AccountId = :accountId 
                                 AND IsWon = true];
    return cwOpps;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getTotalAccountCount () {
    //  The body of the method 
        Integer count = [SELECT COUNT()
                        FROM Account];
        return count;

    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNext7Days () {
    //  The body of the method
    Map<Id, Task> result = new Map<Id, Task>();
    Date eightDaysFromNow = Date.today().addDays(8);
    List<Task> tasks = [SELECT Id
                        FROM Task
                        WHERE ActivityDate >= TODAY 
                        AND ActivityDate <= :eightDaysFromNow];
        for (Task t : tasks) {
            result.put(t.Id, t);
        }
    return result;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsWithExampleDomainEmail () {
        List<Contact> results = [SELECT Id, Email, Name
                                  FROM Contact
                                  WHERE Email LIKE '%example.com'];
        return results;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String searchKey = '%' + keyword + '%';
        List<Opportunity> results = [SELECT Id, Name
                                     FROM Opportunity
                                     WHERE Name LIKE :searchKey];
        return results; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> result = [SELECT Id, Origin 
                              FROM Case
                              WHERE Origin != 'Web'
                              AND Origin != 'Email'
                              AND Origin != ''
                              ];
        return result; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead>  getLeadsBySourceOrTitle (String leadSource, String keyword) {
        String keywordSearch = '%' + keyword + '%';
        List<Lead> leads = [SELECT Id, Title, LeadSource, Company, Phone, Email, LastName
                             FROM Lead
                             WHERE LeadSource = :leadSource
                             OR Title LIKE :keywordSearch];
                        
        return leads;
   }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> lastNames = new List<String>();
        // Query the Contacts
        List<Contact> contactList = [SELECT Id, LastName
                     FROM Contact
                     WHERE AccountId = :accountId];
        // Loop through each Contact and add the LastName to the list
            for (Contact c : contactList) {
                lastNames.add(c.LastName);
            }   
        // Return the list of Contact LastNames
        return lastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        AggregateResult result = [SELECT SUM(Amount) total 
        FROM Opportunity 
        WHERE  Amount > 10000 
        OR StageName = :stage];

        Decimal totalRevenue = (Decimal) result.get('total');
        return totalRevenue; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> firstTenByName = [SELECT Id, Name
                                         FROM Account
                                         ORDER BY Name ASC
                                         LIMIT 10];
        return firstTenByName; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> result = [SELECT Id, Amount, CloseDate
                                     FROM Opportunity
                                     WHERE Amount > 100000
                                     ORDER BY CloseDate ASC 
                                     LIMIT 5];
        return result; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> results = [SELECT Id, Birthdate
                                 FROM Contact
                                 ORDER BY BirthDate DESC
                                 LIMIT 3];
        return results; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> result = [SELECT id, CreatedDate, Status
                             FROM Case
                             ORDER BY CreatedDate
                             LIMIT 10
                             OFFSET 5];
        return result; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();
        List<Case> cases =[SELECT Id, AccountId
                           FROM Case
                           WHERE AccountId = :accountId];               
        // Loop through each Case and add the Id to the set
         for (Case c : cases) {
            caseIds.add(c.Id);
         }
        return caseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> accounts = [SELECT Id, BillingCountry, Name
                                  FROM Account
                                  WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account a : accounts) {
            accountIdsToNames.put(a.Id, a.Name);
        }
        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact contact = [SELECT Account.Name, Id
                             FROM Contact
                             WHERE Id = :contactId];
        return contact.Account.Name; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        Account account = [SELECT Account.Id,
                                  Account.Name,
                                    (
                                    SELECT
                                        Opportunity.Id,
                                        Opportunity.Name
                                    FROM
                                        Opportunities
                                    )
                                FROM
                                    Account
                                WHERE
                                    Id = :accountId];
        return account; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account acc = [SELECT Id, BillingState
                       FROM Account
                       WHERE Id = :accountId];
        // Store the Account's BillingState

        // Query the Contacts
        List<Contact> contacts = [SELECT Id, MailingState
                                  FROM Contact
                                  WHERE MailingState = :acc.BillingState];
        return contacts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> leads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];
        // Create a set of email domains from the Leads
        Set<String> domains = new Set<String>();
        // Loop through each Lead
            for (Lead l : leads) {
                if(!String.isEmpty(l.Email)){
                    String[] emailDomain = l.Email.split('@');
                    domains.add('%' + emailDomain[1]);
                }
            }
        
        // Query the Accounts
        List<Account> results = new List<Account>();
                    for (String s : domains) {
                       List<Account> matchingAccounts = [SELECT Id, Website
                                                         FROM Account
                                                         WHERE Website LIKE :s];
                        results.addAll(matchingAccounts);
                        }
                    
        return results; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> origLineItems = [SELECT PricebookEntryId, Product2Id, UnitPrice
                                                  FROM OpportunityLineItem
                                                  WHERE OpportunityId = :origOppId];
        // Create a list to hold the new line items
        List<OpportunityLineItem> lineItemsToCreate = new List<OpportunityLineItem>();
        // Generate a random number between 1 and 3
        Integer randomQuantity = Integer.valueOf((Math.random() * 10));
        // Loop through each cloned Opportunity Id
            List<Opportunity> cloneOpps = [SELECT Id FROM Opportunity WHERE Id IN :cloneOppIds];
            for (Opportunity o : cloneOpps) {
            // Loop through each original line item
                for (OpportunityLineItem l :origLineItems ) {
                // Clone the original line item and add the random number to the quantity
                    OpportunityLineItem cloneLineItem = new OpportunityLineItem(PricebookEntryId = l.PricebookEntryId, 
                                                                                Product2Id = l.product2Id, 
                                                                                UnitPrice = l.UnitPrice,
                                                                                OpportunityId = o.Id,
                                                                                Quantity = randomQuantity);
                    lineItemsToCreate.add(cloneLineItem);
                } 
             }
        // Insert the new line items
        insert lineItemsToCreate;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {   
        List<Opportunity> cwOpps = [SELECT Id, Name, Account.Name, Owner.Name
                                    FROM Opportunity
                                    WHERE StageName = :'Closed Won'];     
        return cwOpps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> opps = getOpportunityDetailsForClosedWon();
        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : opps) {
            accountIds.add(opp.AccountId);
        }
        // Query the Contacts

        // Loop through each Contact and add the Account Id and Contact to the map
        Map<Id,Contact> accountIdsToContacts = new Map<Id, Contact>();
        for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds]) {
            accountIdsToContacts.put(con.AccountId, con);
        }
        // Loop through each Opportunity
        for (Opportunity o : opps) {
                // Update the Opportunity primary contact from accountToContactMap
                Contact primaryContact = accountIdsToContacts.get(o.AccountId);
                o.Primary_Contact__c = primaryContact.Id;
            }
        // Update the Opportunities
        update opps;
    }
}