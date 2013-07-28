RateYourWriting
===============

Back when I was in high school I was a member of an online writer's community called
RateYourWriting.com. That site is long gone now, but I thought it might be fun to recreate it from
my memories, with the help of the [Internet Archive](http://archive.org/index.php) and its
[Wayback Machine](http://archive.org/web/web.php).

Chances are that this project, like so many others, will dissipate into nothingness. But who knows?

Getting started on Mac OSX
--------------------------

1. Install PostgreSQL using Homebrew:

    brew install postgres

2. Make sure `usr/local/bin` comes before `/usr/bin` in /etc/paths (to use Homebrew's Postgres instead of Mac's built-in version)

3. Install gem dependencies (do this **after installing PostgreSQL with Homebrew**; otherwise the pg gem will use the system-installed version):

    bundle install

3. Create the necessary DBs:

    createdb ryw_development
    createdb ryw_test

4. Rename database.example.yml to database.yml and update its contents as necessary

5. (Optional) Add seed data to the db/ folder. Here's a link to a seeds.tar.gz file in Dropbox that will probably be dead by the time anyone ever reads this:

> https://www.dropbox.com/s/yf36anuzcav3w97/seed.tar.gz

6. `rake db:reset`

7. `rails server`
