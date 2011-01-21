## Intro

The [Google Apps Shared Contacts API Guide](http://code.google.com/googleapps/domain/shared_contacts/gdata_shared_contacts_api_reference.html) clearly states that the API "is only available to Google Apps for Business and Education accounts".  This little spike is to test what happens when I try to use that API with a standard GAFYD account.

The contact.xml document is taken straight from that API guide.

## Conclusion

I used this test script to create multiple contacts via the API.  I checked after around 48 hours and the contacts weren't available in GMail autocomplete or the Contact editor so I guess it really isn't available with a standard GAFYD account...

## Usage

    $ ./google-shared-contacts.rb auth 'YOUR-EMAIL-ADDRESS' 'YOUR-PASSWORD' > google-token
    $ ./google-shared-contacts.rb create `cat google-token` 'YOUR-DOMAIN' 'contact.xml'
    $ ./google-shared-contacts.rb list `cat google-token` 'YOUR-DOMAIN'