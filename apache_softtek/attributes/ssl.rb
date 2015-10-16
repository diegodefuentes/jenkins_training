
#
# When we also provide SSL we have to listen to the
# the HTTPS port in addition.
#
default['apache']['SSLport'] = 443

default['apache']['Builtin'] = 'builtin'

#   Inter-Process Session Cache:
#   Configure the SSL Session Cache: First the mechanism
#   to use and second the expiring timeout (in seconds).
default['apache']['SSLSessionCacheTimeout'] = 300

#   Semaphore:
#   Configure the path to the mutual exclusion semaphore the
#   SSL engine uses internally for inter-process synchronization.
default['apache']['SSLMutex'] = 'file:/var/run/ssl_mutex'

# Use separate log files for the SSL virtual host; note that LogLevel
# is not inherited from httpd.conf.
default['apache']['SSLErrorLog'] =  'logs/ssl_error_log'
default['apache']['SSLAccessLog'] =  'logs/ssl_access_log'

default['apache']['SSLProtocol'] =  'all -SSLv2 -SSLv3'
default['apache']['SSLCipherSuite'] =  'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4'

default['apache']['SSLStrictSNIVHostCheck'] =  'off'
default['apache']['SSLHonorCipherOrder'] =  'on'

default['apache']['SSLVerifyClient'] =  'none'

default['apache']['SSLInsecureRenegotiation'] =  'off'