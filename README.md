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
than the Terms and Conditions which the user may have accepted -- this is a bug.)

