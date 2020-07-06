# Applications I could develop if time permits

## Bundesordner
An application that keeps track of your Personal or Business files in the digital realm. Save Files as content addressed blobs and Order them by a folder structure. Files are indexed by date, tags and People connected to them.
- Folder
  - Has path and not just name
    - Path is translated into structure in frontend
  - Limited to make it not too complex (4 layers?)
  - Tags to find things
  - Date to refine search
  - One Folder has many files
  - creation, and modification (last time something got added) date
  - Undeleteable attribute Which archives folders
    - Archived folders are hidden
  - Retention Point to get rid of old stuff
  - Holds default properties for all filed within
  - Can prevent files from having own properties
- Files
  - creation date
  - has many blobs (versions)
  - Can be unversioned
  - can be read-only
  - unversioned and read-only == Archive
- Inbox
  - Entry point for all documents (everything goes through here)
  - Documents that are scanned are deposited here
- Workspace
  - Only place where one can edit documents
  - Documents here are unversioned
  - They can be commited to a folder but in doing so get closed
  - Files open here are locked to that user