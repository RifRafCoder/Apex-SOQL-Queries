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
* @author Rafia Wakaar
*/

public with sharing class SOQL {
    
    /** 
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
        List<Lead> listOfLeads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        return listOfLeads;
    }

    /**
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getAllContacts() {
        List<Contact> contactJohn = [SELECT Id, FirstName, LastName, Name FROM Contact WHERE FirstName = 'John'];
        return contactJohn;
    }

    /**
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactId() {
        List<Contact> contactNameList = [SELECT Id, FirstName, LastName, Name FROM Contact WHERE (LastName = 'Smith' OR LastName = 'Jones')];
        List<Id> contactId = new List<Id>();
        for(Contact cont : contactNameList){
            contactId.add(cont.Id);
        }
        return contactId;
    }

    /**
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> closedWonOpps(Id accountId) {
        List<Opportunity> listOfOpps = [SELECT Id, Name, StageName, CloseDate, AccountId, Amount FROM Opportunity WHERE StageName = 'Closed Won' AND AccountId = :accountId];
        return listOfOpps;
    }

    /**
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer totalAccounts() {
        Integer countOfAccounts = [SELECT COUNT() FROM Account];
        return countOfAccounts;
    }

    /**
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> taskMap() {
        Date nextWeek = Date.today().addDays(7);
        List<Task> tasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate <= :nextWeek];
        Map<Id, Task> mapIdsTasks = new Map<Id, Task>();
        for(Task t : tasks){
            mapIdsTasks.put(t.Id, t);
        }
        return mapIdsTasks;
    }

    /**
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> listOfConts() {
        List<Contact> conts = [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE Email LIKE '%example.com'];
        return conts;
    }

    /**
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String searchTerm = '%' + keyword + '%';
        List<Opportunity> oppKeyword = [SELECT Id, Name, StageName, CloseDate, AccountId FROM Opportunity WHERE Name LIKE :searchTerm];
        return oppKeyword; // Replace null with the variable you used to store the result
    }

    /**
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> filterCase = [SELECT Status, AccountId, Origin FROM Case WHERE Origin != 'Web' AND Origin != 'Email' AND Origin != ''];
        return filterCase; // Replace null with the variable you used to store the result
    }

    /**
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrDescription method to cover this method
     */
    public static List<Lead> listOfLeadsKey(String leadSource, String keyword) {
        String titleDesc = '%' + keyword + '%';
        List<Lead> leadsList = [SELECT LastName, Company, Phone, Email, LeadSource, Title FROM Lead WHERE LeadSource = :leadSource OR Title LIKE :titleDesc];
        return leadsList;
    }    

    /**
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> lastNames = new List<String>();
        // Query the Contacts
        List<Contact> contacts = [SELECT LastName, AccountId FROM Contact WHERE AccountId = :accountId];
        // Loop through each Contact and add the LastName to the list
        for (Contact con : contacts) {
            lastNames.add(con.LastName);
        }

        // Return the list of Contact LastNames
        return lastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        AggregateResult[] totalRevOpp = [SELECT SUM(Amount)sumAm FROM Opportunity WHERE StageName = :stage OR Amount > 10000];
        // Return the total revenue
        Decimal result = (Decimal) totalRevOpp[0].get('sumAm');
        return result; // Replace null with the variable you used to store the result
    }

    /**
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> accList = [SELECT Name FROM Account ORDER BY Name ASC LIMIT 10];
        return accList; // Replace null with the variable you used to store the result
    }
    
    /**
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> listOpps = [SELECT Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5];
        return listOpps; // Replace null with the variable you used to store the result
    }
    
    /**
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> listCon = [SELECT Birthdate FROM Contact ORDER BY Birthdate DESC LIMIT 3];
        return listCon; // Replace null with the variable you used to store the result
    }
    
    /**
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> listCases = [SELECT Status, CreatedDate FROM Case WHERE Status = 'Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];
        return listCases; // Replace null with the variable you used to store the result
    }

    /**
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseId = new Set<Id>();
        // Query the Cases
        List<Case> listCases = [SELECT AccountId FROM Case WHERE AccountId = :accountId];
        // Loop through each Case and add the Id to the set
        for(Case c : listCases) {
            caseId.add(c.Id);
        }

        return caseId; // Replace null with the variable you used to store the result
    }

    /**
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> accountsList = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for(Account acc : accountsList){
            accountIdsToNames.put(acc.Id, acc.Name);
        }
        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact getContact =  [SELECT Id, Account.Name FROM Contact WHERE Id = :contactId];
        String accName = getContact.Account.Name;
        return accName; // Replace null with the variable you used to store the result
    }    

    /**
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        Account accAndOpps = [SELECT Id, Name, (SELECT Id, Name, StageName, CloseDate FROM Opportunities) FROM Account WHERE Id = :accountId];
        return accAndOpps; // Replace null with the variable you used to store the result
    }

    /**
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return A list of maps containing the Account's MailingState and the related Contacts.
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account getAccount = [SELECT Id, BillingState FROM Account WHERE Id = :accountId];
        // Store the Account's BillingState
        String accBillingState = getAccount.BillingState;
        // Query the Contacts
        List<Contact> contactList = [SELECT MailingState FROM Contact WHERE MailingState = :accBillingState];
        return contactList; // Replace null with the variable you used to store the result
    }

    /**
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A list of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> leadList = [SELECT Email FROM Lead WHERE Id IN :leadIds];
        // Create a set of email domains from the Leads
        Set<String> emailLeads = new Set<String>();
        // Loop through each Lead
        for(Lead l : leadList){
            // Get the email from the Lead
            String email = l.Email;
            // Check if the email is not null
            If(email != null){
                // Add the email domain to the set
                Integer atIndex = email.indexOf('@');
                String domain = email.substring(atIndex + 1);
                emailLeads.add(domain);
            }
        }
        // Query the Accounts
        List<Account> accsList = [SELECT Website FROM Account WHERE Website IN :emailLeads];
        return accsList; // Replace null with the variable you used to store the result
    }

    /**
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> orignal = [SELECT Id, OpportunityId, PricebookEntryId, UnitPrice, TotalPrice, Quantity FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
        
        // Create a list to hold the new line items
        List<OpportunityLineItem> newItems = new List<OpportunityLineItem>();
        // Generate a random number between 1 and 3
        Integer random = (Integer)Math.floor(Math.random() * 3) + 1;
        // Loop through each cloned Opportunity Id
        for(Id clone : cloneOppIds){
            // Loop through each original line item
            for(OpportunityLineItem orgLineItem : orignal){
                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem newLineItem = new OpportunityLineItem(
                    OpportunityId = clone,
                    PriceBookEntryId = orgLineItem.PriceBookEntryId,
                    UnitPrice = orgLineItem.UnitPrice,
                    Quantity = orgLineItem.Quantity + random
                );
                
                newItems.add(newLineItem);
            }
        }
        // Insert the new line items
        insert newItems;
    }
    
    /**
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {
        List<Opportunity> oppsList = [SELECT Name, AccountId, OwnerId, StageName FROM Opportunity WHERE StageName = 'Closed Won'];        
        return oppsList; // Replace null with the variable you used to store the result
    }

    /**
     * Sets the 'Primary_Contact__c' field for the provided Opportunities from the first related Contact of the Account, ordered by first name.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     * @param A list of 'Closed Won' Opportunities.
    */
    public static void setPrimaryContact(List<Opportunity> closedWon) {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();
        // Create a set of Account Ids from the Opportunities
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp: closedWonOpps){
            accIds.add(opp.AccountId);
        }
        // Query the Contacts
        List<Contact> contactsList = [SELECT Id, AccountId, FirstName FROM Contact WHERE AccountId IN :accIds ORDER BY FirstName LIMIT 1];
        // Loop through each Contact and add the Account Id and Contact to the map
        Map<Id, Contact> accountToContactMap = new Map<Id,Contact>();
        for(Contact con : contactsList){
            accountToContactMap.put(con.AccountId, con);
        }

        // Loop through each Opportunity
        for(Opportunity opp: closedWonOpps){
                // Update the Opportunity primary contact from accountToContactMap
            opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId).Id;
        }
        // Update the Opportunities
        update closedWonOpps;
    }
    
}