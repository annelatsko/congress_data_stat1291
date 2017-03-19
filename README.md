# congress_data_stat1291
Relevant files:
1. full_data.csv
2. new_members.csv

## Weird stuff with the data:
There was some weird stuff with the data that was obtained from FiveThirtyEight, specifically, there were some people who had their suffix and their last name in the opposite position. It is resolved in both the dirty_data/OG_congress-terms.csv and clean_data/congress-terms.csv. The congress-terms.csv that's not in clean_data is the original file I downloaded with no changes.


### If you don't actually care about using GitHub and just want the full_data.csv:
Easy, hit the green button on the far right that says "Clone or download" and select "Download ZIP".
*Be warned that the data might change as stuff gets added. Be sure that you check for updates.*

### If you do care about using Github
If you already have GitHub setup, skip to step 3 for general workflow:
1. Create a GitHub account and login
2. Follow these instructions to get git setup on your computer https://help.github.com/articles/set-up-git/. Lemme know if you want help.
3. Click the green button on the far right that says "Clone or download" and just hit the "copy to clipboard button" on the right of the url that you see.
4. Create a folder where you want to clone this project. If you want to use command line, run `mkdir <name_of_folder>`. Otherwise, just do it normally.
5. Open the command line. Navigate to the folder that you just created using `cd`. If you're on Windows, you can right click on the folder that you created in the File Explorer and select Properties at the bottom. This will show you the path that you need to take to `cd` into it. If you're looking at where you're currently at w/r/t path in the command line and have no idea how to get there, enter `cd ..` over and over again until you're at the base C: folder. Then, just follow the path that you found in properties. For example, if your path is "C:/Users/Annie/folder_for_project", first run `cd Users`, then run `cd Annie`, then run `cd folder_for_project` and you'll be in the folder.
6. Run `git clone <the URL you copied from step 3>`. This will clone the project into the folder that you just created. If you go into the File Explorer, you should be able to see that the files have been added.
7. Now that you have the files that you want, you can `cd` into the folder whenever you want and run `git pull origin master`. This will allow you to automatically pull any changes that I've made recently so that you have the most up to date files without having to recopy/redownload them.

### If you're interested in running the python files yourself:
1. Install Python. I'm using 2.7. I suggest using Anaconda for the installation.
2. Using the command line, navigate to the project that you cloned/downloaded.
3. Run `python data_cleaner.py`
4. Run `python agglomerate.py`
5. Run `python isolate_new_members.py`

data_cleaner.py should be run before agglomerate.py. Run isolate_new_members.py last.

### How to Contribute:
Everyone needs to hmu w/their GitHub username so that I can add you as a collaborater.

#### Without using the command line:
This is a bad way to do it, but just hit the edit button on the file that you contributed to and then add your stuff at the bottom. Mark it with your name in a comment. If you change any work that anyone else did, leave a note or whatever. Hit the green button at the bottom to commit it. Leave a note detailing what you changed. If something bad happens, I'll fix it.

#### With the command line:
1. Be in the project's folder on the command line.
2. Run `git add .`
3. Run `git status` to make sure that everything is green.
4. Run `git commit -m "<commit message>"`
5. Run `git push origin master`
Again, if anything breaks or if you get a merge conflict message, I'll fix it.

