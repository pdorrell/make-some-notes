Make Some Notes
===============

**Make Some Notes** is a Ruby on Rails web application that allows
users to create, edit and delete notes.

Terms and Conditions
--------------------

An important feature of **Make Some Notes** is the **Terms and Conditions**.

Terms and conditions are manage by a special admin user.

The rules for creating terms and conditions are as follows:

* There can be multiple versions of the Terms and Conditions.
* Versions are number 1 up.
* At any time, there can be only one published version of Terms and conditions.
* At any time, there can be at most one new unpublished version of the
  Terms and Conditions.
* The admin user can create a new version of the Terms and Conditions. This will
  be derived from the current published version, or if there is no published version
  yet, a default template will be used. It will be numbered with the next number
  after the published version number, or if there is no published version number, it
  will be version 1.
* The admin user can edit the new version.
* The admin user can choose to publish the new version, at which point any existing
  published version is **superceded**, and the new version becomes the published version.

Non-admin application users are required to accept any Terms and Conditions before they
are allowed to create, edit or delete notes.

The rules for accepting terms and conditions are as follows:

* At the time of creating a user, and whenever a user logs in, the application determines
  which version is the published version (if any), and records this version number as being
  the version which the user is required to accept.
* The application also records the number of the last version accepted by the user (which starts
  out empty).
* Whenever the version required to be accepted is not the same as the last version accepted
  by the user, the user will not have the ability to create, edit or delete notes until the
  specified new Terms and Conditions have been accepted. A notice to this effect will be displayed
  on the application home page whenever the user is logged in.

At any time, if a user has accepted the latest version of the Terms and Conditions which they are
required to accept, the user can still read those Terms and Conditions via the home page. (Actually,
currently this is a link to the latest *published* Terms and Conditions, which may be more recent
than the last version of the Terms and Conditions which the user has accepted -- this is a bug.)

Technologies Used in This Application
=====================================

* Ruby on Rails 4.0.0
* Ruby 1.9.3
* Devise
* CanCan
* SimpleForm
* Bootstrap-SASS

Database Tables
===============

There are currently 4 application-specific tables in the application database:

* **users**, this contains user information, as created by Devise. 3 additional columns
  are **is_admin**, **latest_terms_version**, **accepted_terms_version**.
* **notes**, which contains the notes. It has data columns **title** and **text**.
  Each note belongs to a user, and users can only see those notes which they created.
* **user_agreements**, which contains all the versions of the Terms and Conditions.
  I used the term "User Agreement", because "Terms and Conditions" is pluralised even when
  there is only one of them, which is liable to cause problems when Rails starts pluralizing
  and singularizing names of things. Each "User Agreement" has data columns **text** for 
  the main text of the agreeemnt, and **comment** for a descriptive comment. Two important
  date columns are **published_at**, which is filled in when a new version is published, 
  and **superceded_at**, which is filled in when a currently published version is replaced
  by publishing a new version.
* **versioned_documents** contains one row identifying which versions (if any) of the Terms
  and Conditions are published and new. (If there were different types of document to be versioned,
  there might be one row for each such document type, but currently that is just a hypothetical
  possibility.)


