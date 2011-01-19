## Intro

The [Google Apps Shared Contacts API Guide](http://code.google.com/googleapps/domain/shared_contacts/gdata_shared_contacts_api_reference.html) clearly states that the API "is only available to Google Apps for Business and Education accounts".  This little spike is to test what happens when I try to use that API with a standard GAFYD account.

The contact.xml document is taken straight from that API guide.

## Usage

    $ ./google-shared-contacts.rb auth 'YOUR-EMAIL-ADDRESS' 'YOUR-PASSWORD' > google-token
    $ ./google-shared-contacts.rb create `cat google-token` 'YOUR-DOMAIN' 'contact.xml'
    $ ./google-shared-contacts.rb list `cat google-token` 'YOUR-DOMAIN'