# Plex Scripts


## update_release_date.sh
Script iterates recursively from parent directory (passed as argument) and defaults ContentCreateDate to 1969-12-31 if field does not already exist with a meaningful value.   
Script can easily be modfied for other metadata

### Why
I've had issues with Plex assigning bad "release dates" to home videos. With many videos (assets), managing a library gets unwieldly. This scripts helps automate library management and organization.  

### Requirements
- [exiftool](https://exiftool.org/install.html)

### Instructions
#### Bulk Unlock Plex Assets' attributes
In Plex, you may have multiple assets with locked metadata fields  
<img src="images/locked_release_date.png" alt="Locked Release Date" width="500"/>  
However, updating the underlying file's metadata and refreshing metadata in Plex will not overwrite these locked fields.  

This method leverages Plex API rather than relying on GUI.  
Acquire your token and library key by following these [directions](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/), [see also](old.reddit.com/r/PleX/comments/mwzbh5/is_there_any_easy_way_to_unlock_tags_on_metadata/)  

In your internet browser, navigate to your plex library. Open your browser's console, and run this call with your appropriate fields. 
```
fetch('http://127.0.0.1:32400/library/sections/YOUR_LIBRARY_KEY_HERE/all?type=1&originallyAvailableAt.locked=0&X-Plex-Token=YOUR_TOKEN_HERE', { method : "PUT" })
```

In this example, we're unlocking OriginallyAvailableAt field by setting it to 0 for all assets.    
You can explore other fields by viewing XML tags on an asset.  

#### Running the Script from Command Line
```
chmod +x ./update_release_date.sh
./update_release_date.sh /Volumes/External_Media/media_library/home_videos
```
