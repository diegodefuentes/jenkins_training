### Platform dependent PATHs
case node[:platform]
when 'amazon','redhat', 'centos', 'fedora'
  default['apache']['appfolder'] =  '/etc/httpd'
  default['apache']['conffolder'] =  'conf.d'
  default['apache']['conffile'] =  'httpd.conf'
when 'ubuntu', 'debian'
  default['apache']['appfolder'] =  '/etc/apache2'
  default['apache']['conffolder'] =  'mods-available'
  default['apache']['conffile'] =  'apache2.conf'
  default['apache']['extraconf'] =  'conf-available'
  case node[:platform_version]
  when '12.04'
  default['apache']['extraconf'] =  'conf.d'
  end
end


### Section 1: Global Environment
#
# The directives in this section affect the overall operation of Apache,
# such as the number of concurrent requests it can handle or where it
# can find its configuration files.
#

#
# Don't give away too much information about all the subcomponents
# we are running.  Comment out this line if you don't mind remote sites
# finding out what major optional modules you are running
default['apache']['ServerTokens'] =  'Prod'
#
# ServerRoot: The top of the directory tree under which the server's
# configuration, error, and log files are kept.
#
# NOTE!  If you intend to place this on an NFS (or otherwise network)
# mounted filesystem then please read the LockFile documentation
# (available at <URL:http://httpd.apache.org/docs/2.2/mod/mpm_common.html#lockfile>);
# you will save yourself a lot of trouble.
#
# Do NOT add a slash at the end of the directory path.
#

#
# PidFile: The file in which the server should record its process
# identification number when it starts.  Note the PIDFILE variable in
# /etc/sysconfig/httpd must be set appropriately if this location is
# changed.
#
default['apache']['PidFile'] =  'run/httpd.pid'

#
# Timeout: The number of seconds before receives and sends time out.
#
default['apache']['Timeout'] = 60

#                                                                                 
# KeepAlive: Whether or not to allow persistent connections (more than            
# one request per connection). Set to "Off" to deactivate.                        
#                                                                                 
default['apache']['KeepAlive'] =  'Off'

#
# MaxKeepAliveRequests: The maximum number of requests to allow
# during a persistent connection. Set to 0 to allow an unlimited amount.
# We recommend you leave this number high, for maximum performance.
#
default['apache']['MaxKeepAliveRequests'] = 100

#
# KeepAliveTimeout: Number of seconds to wait for the next request from the
# same client on the same connection.
#
default['apache']['KeepAliveTimeout'] = 15

# prefork MPM
# StartServers: number of server processes to start
# MinSpareServers: minimum number of server processes which are kept spare
# MaxSpareServers: maximum number of server processes which are kept spare
# ServerLimit: maximum value for MaxClients for the lifetime of the server
# MaxClients: maximum number of server processes allowed to start
# MaxRequestsPerChild: maximum number of requests a server process serves
default['apache']['StartServers'] = 8
default['apache']['MinSpareServers'] = 5
default['apache']['MaxSpareServers'] = 20
default['apache']['ServerLimit'] = 256
default['apache']['MaxClients'] = 256
default['apache']['MaxRequestsPerChild'] = 4000

# worker MPM
# StartServers: initial number of server processes to start
# MaxClients: maximum number of simultaneous client connections
# MinSpareThreads: minimum number of worker threads which are kept spare
# MaxSpareThreads: maximum number of worker threads which are kept spare
# ThreadsPerChild: constant number of worker threads in each server process
# MaxRequestsPerChild: maximum number of requests a server process serves
default['apache']['WorkerStartServers'] = 4
default['apache']['WorkerMaxClients'] = 256
default['apache']['MinSpareThreads'] = 25
default['apache']['MaxSpareThreads'] = 75
default['apache']['ThreadsPerChild'] = 25
default['apache']['WorkerMaxRequestsPerChild'] = 0
default['apache']['ThreadLimit'] = 64

#
# Listen: Allows you to bind Apache to specific IP addresses and/or
# ports, in addition to the default. See also the <VirtualHost>
# directive.
#
# Change this to Listen on specific IP addresses as shown below to
# prevent Apache from glomming onto all bound IP addresses (0.0.0.0)
#
#Listen 12.34.56.78:80
default['apache']['port'] = 80
                                                                                                                                                              

#
# Load config files from the config directory "/etc/httpd/conf.d".
#
case node[:platform]
when 'amazon','redhat', 'centos', 'fedora'
default['apache']['IncludeConf'] =  'conf.d/*.conf'
when 'ubuntu', 'debian'
default['apache']['IncludeConf'] =  'conf-enabled/*.conf'
case node[:platform_version]
when '12.04'
default['apache']['IncludeConf'] =  'conf.d/*.conf'
end
end

#
# ExtendedStatus controls whether Apache will generate "full" status
# information (ExtendedStatus On) or just basic information (ExtendedStatus
# Off) when the "server-status" handler is called. The default is Off.
#
default['apache']['ExtendedStatus'] =  'On'

#
# If you wish httpd to run as a different user or group, you must run
# httpd as root initially and it will switch.
#
# User/Group: The name (or #number) of the user/group to run httpd as.
#  . On SCO (ODT 3) use "User nouser" and "Group nogroup".
#  . On HPUX you may not be able to use shared memory as nobody, and the
#    suggested workaround is to create a user www and use that user.
#  NOTE that some kernels refuse to setgid(Group) or semctl(IPC_SET)
#  when the value of (unsigned)Group is above 60000;
#  don't use Group #-1 on these systems!
#
case node[:platform]
when 'amazon','redhat', 'centos', 'fedora'
default['apache']['user'] =  'apache'
default['apache']['group'] =  'apache'
when 'ubuntu', 'debian'
default['apache']['user'] =  'www-data'
default['apache']['group'] =  'www-data'
end

#                                                                                 
# ServerAdmin: Your address, where problems with the server should be             
# e-mailed.  This address appears on some server-generated pages, such            
# as error documents.  e.g. admin@your-domain.com                                 
#                                                                                 
default['apache']['ServerAdmin'] =  'admin@example.com'

#
# ServerName gives the name and port that the server uses to identify itself.
# This can often be determined automatically, but we recommend you specify
# it explicitly to prevent problems during startup.
#
# If this is not set to valid DNS name for your host, server-generated
# redirections will not work.  See also the UseCanonicalName directive.
#
# If your host doesn't have a registered DNS name, enter its IP address here.
# You will have to access it by its address anyway, and this will make
# redirections work in a sensible way.
#
default['apache']['ServerName'] =  'www.example.com'

#
# UseCanonicalName: Determines how Apache constructs self-referencing
# URLs and the SERVER_NAME and SERVER_PORT variables.
# When set "Off", Apache will use the Hostname and Port supplied
# by the client.  When set "On", Apache will use the value of the
# ServerName directive.
#
default['apache']['UseCanonicalName'] =  'Off'

#
# DocumentRoot: The directory out of which you will serve your
# documents. By default, all requests are taken from this directory, but
# symbolic links and aliases may be used to point to other locations.
#
default['apache']['DocumentRoot'] =  '/var/www/html'


#
# Each directory to which Apache has access can be configured with respect
# to which services and features are allowed and/or disabled in that
# directory (and its subdirectories).
#

default['apache']['RootDirectory'] =  '/'
#
# We include the /icons/ alias for FancyIndexed directory listings.  If you
# do not use FancyIndexing, you may comment this out.
#
default['apache']['IconsDirectory'] =  '/var/www/icons/'
#
# ScriptAlias: This controls which directories contain server scripts.
# ScriptAliases are essentially the same as Aliases, except that
# documents in the realname directory are treated as applications and
# run by the server when requested rather than as documents sent to the client.
# The same rules about trailing "/" apply to ScriptAlias directives as to
# Alias.
#
case node[:platform]
when 'amazon','redhat', 'centos', 'fedora'
default['apache']['ScriptsDirectory'] =  '/var/www/cgi-bin/'
when 'ubuntu', 'debian'
default['apache']['ScriptsDirectory'] =  '/usr/lib/cgi-bin/'
end
default['apache']['ErrorDirectory'] =  '/var/www/error/'

#
# Possible values for the Options directive are "None", "All",
# or any combination of:
#   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
#
# Note that "MultiViews" must be named *explicitly* --- "Options All"
# doesn't give it to you.
#
# The Options directive is both complicated and important.  Please see
# http://httpd.apache.org/docs/2.2/mod/core.html#options
# for more information.
#
default['apache']['OptionFollowSymlinks'] =  '+FollowSymLinks'
#
# AllowOverride controls what directives may be placed in .htaccess files.
# It can be "All", "None", or any combination of the keywords:
#   Options FileInfo AuthConfig Limit
#
default['apache']['OptionAllowOverride'] =  'None'
default['apache']['OptionIndexes'] =  '-Indexes'
default['apache']['OptionMultiViews'] =  'MultiViews'
default['apache']['OptionNone'] =  'None'
default['apache']['IncludesNoExec'] =  'IncludesNoExec'

#
# Controls who can get stuff from this server.
#
default['apache']['Order'] =  'allow,deny'
default['apache']['Allow'] =  'from all'
default['apache']['Deny'] =  'from all'
default['apache']['Satisfy'] =  'All'

#
# UserDir: The name of the directory that is appended onto a user's home
# directory if a ~user request is received.
#
# The path to the end user account 'public_html' directory must be
# accessible to the webserver userid.  This usually means that ~userid
# must have permissions of 711, ~userid/public_html must have permissions
# of 755, and documents contained therein must be world-readable.
# Otherwise, the client will only receive a "403 Forbidden" message.
#
# See also: http://httpd.apache.org/docs/misc/FAQ.html#forbidden
#
    #
    # UserDir is disabled by default since it can confirm the presence
    # of a username on the system (depending on home directory
    # permissions).
    #
default['apache']['UserDir'] =  'disabled'
    #
    # To enable requests to /~user/ to serve the user's public_html
    # directory, remove the "UserDir disabled" line above, and uncomment
    # the following line instead:
    #
    #UserDir public_html

	#
# DirectoryIndex: sets the file that Apache will serve if a directory
# is requested.
#
# The index.html.var file (a type-map) is used to deliver content-
# negotiated documents.  The MultiViews Option can be used for the
# same purpose, but it is much slower.
#
default['apache']['DirectoryIndex'] =  'index.html'

#
# AccessFileName: The name of the file to look for in each directory
# for additional configuration directives.  See also the AllowOverride
# directive.
#
default['apache']['AccessFileName'] =  '.htaccess'

#
# TypesConfig describes where the mime.types file (or equivalent) is
# to be found.
#
default['apache']['TypesConfig'] =  '/etc/mime.types'

#
# DefaultType is the default MIME type the server will use for a document
# if it cannot otherwise determine one, such as from filename extensions.
# If your server contains mostly text or HTML documents, "text/plain" is
# a good value.  If most of your content is binary, such as applications
# or images, you may want to use "application/octet-stream" instead to
# keep browsers from trying to display binary files as though they are
# text.
#
default['apache']['DefaultType'] =  'text/plain'

#
# The mod_mime_magic module allows the server to use various hints from the
# contents of the file itself to determine its type.  The MIMEMagicFile
# directive tells the module where the hint definitions are located.
#
default['apache']['MIMEMagicFile'] =  'conf/magic'

#
# HostnameLookups: Log the names of clients or just their IP addresses
# e.g., www.apache.org (on) or 204.62.129.132 (off).
# The default is off because it'd be overall better for the net if people
# had to knowingly turn this feature on, since enabling it means that
# each client request will result in AT LEAST one lookup request to the
# nameserver.
#
default['apache']['HostnameLookups'] =  'Off'

#                                                                         
# EnableMMAP: Control whether memory-mapping is used to deliver           
# files (assuming that the underlying OS supports it).                    
# The default is on; turn this off if you serve from NFS-mounted          
# filesystems.  On some systems, turning it off (regardless of            
# filesystem) can improve performance; for details, please see            
# http://httpd.apache.org/docs/2.2/mod/core.html#enablemmap               
#                                                                         
default['apache']['EnableMMAP'] =  'off'

#
# EnableSendfile: Control whether the sendfile kernel support is
# used to deliver files (assuming that the OS supports it).
# The default is on; turn this off if you serve from NFS-mounted
# filesystems.  Please see
# http://httpd.apache.org/docs/2.2/mod/core.html#enablesendfile
#
default['apache']['EnableSendfile'] =  'off'

#
# ErrorLog: The location of the error log file.
# If you do not specify an ErrorLog directive within a <VirtualHost>
# container, error messages relating to that virtual host will be
# logged here.  If you *do* define an error logfile for a <VirtualHost>
# container, that host's errors will be logged there and not here.
#
default['apache']['ErrorLog'] =  'logs/error_log'

#
# LogLevel: Control the number of messages logged to the error_log.
# Possible values include: debug, info, notice, warn, error, crit,
# alert, emerg.
#
default['apache']['LogLevel'] =  'warn'

#
# For a single logfile with access, agent, and referer information
# (Combined Logfile Format), use the following directive:
#
default['apache']['LogLocation'] =  'logs/access_log'
default['apache']['LogType'] =  'combined'

#
# Optionally add a line containing the server version and virtual host
# name to server-generated pages (internal error documents, FTP directory
# listings, mod_status and mod_info output etc., but not CGI generated
# documents or custom error documents).
# Set to "EMail" to also include a mailto: link to the ServerAdmin.
# Set to one of:  On | Off | EMail
#
default['apache']['ServerSignature'] =  'Off'

#
# WebDAV module configuration section.
#
default['apache']['DAVLockDB'] =  '/var/lib/dav/lockdb'

#                                                                                  
# DefaultIcon is which icon to show for files which do not have an icon            
# explicitly set.                                                                  
#                                                                                  
default['apache']['DefaultIcon'] =  '/icons/unknown.gif'

#
# ReadmeName is the name of the README file the server will look for by
# default, and append to directory listings.
#
# HeaderName is the name of a file which should be prepended to
# directory indexes.

default['apache']['ReadmeName'] =  'README.html'
default['apache']['HeaderName'] =  'HEADER.html'

#
# DefaultLanguage and AddLanguage allows you to specify the language of
# a document. You can then use content negotiation to give a browser a
# file in a language the user can understand.
#
# Specify a default language. This means that all data
# going out without a specific language tag (see below) will
# be marked with this one. You probably do NOT want to set
# this unless you are sure it is correct for all cases.
#
# * It is generally better to not mark a page as
# * being a certain language than marking it with the wrong
# * language!
#
default['apache']['DefaultLanguage'] =  'es'
#
# Note 1: The suffix does not have to be the same as the language
# keyword --- those with documents in Polish (whose net-standard
# language code is pl) may wish to use "AddLanguage pl .po" to
# avoid the ambiguity with the common suffix for perl scripts.
#
# Note 2: The example entries below illustrate that in some cases
# the two character 'Language' abbreviation is not identical to
# the two character 'Country' code for its country,
# E.g. 'Danmark/dk' versus 'Danish/da'.
#
# Note 3: In the case of 'ltz' we violate the RFC by using a three char
# specifier. There is 'work in progress' to fix this and get
# the reference data for rfc1766 cleaned up.
#
# Catalan (ca) - Croatian (hr) - Czech (cs) - Danish (da) - Dutch (nl)
# English (en) - Esperanto (eo) - Estonian (et) - French (fr) - German (de)
# Greek-Modern (el) - Hebrew (he) - Italian (it) - Japanese (ja)
# Korean (ko) - Luxembourgeois* (ltz) - Norwegian Nynorsk (nn)
# Norwegian (no) - Polish (pl) - Portugese (pt)
# Brazilian Portuguese (pt-BR) - Russian (ru) - Swedish (sv)
# Simplified Chinese (zh-CN) - Spanish (es) - Traditional Chinese (zh-TW)
#

#
# Specify a default charset for all content served; this enables
# interpretation of all content as UTF-8 by default.  To use the
# default browser choice (ISO-8859-1), or to allow the META tags
# in HTML content to override this choice, comment out this
# directive:
#
default['apache']['AddDefaultCharset'] =  'UTF-8'