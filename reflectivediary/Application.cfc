component extends="org.corfield.framework" {
	this.name = 'appReflectiveDiary-' & hash(getCurrentTemplatePath());

	this.appRootPath = getDirectoryFromPath(getCurrentTemplatePath());
	this.webRootPath = getDirectoryFromPath(expandPath('/'));

	this.sessionManagement = true;
	this.applicationTimeout = createTimeSpan(10,0,0,0);

// stop bots creating sessions
	if (structKeyExists(cookie,'JSESSIONID') || structKeyExists(cookie, 'CFTOKEN')) {
		this.sessionTimeout = createTimeSpan(0,0,120,0);
	} else {
		this.sessionTimeout = createTimeSpan(0,0,0,1);
	}

	this.clientManagement = false;

	this.mappings['/com'] = this.webRootPath & '../com/';
	this.mappings['/model'] = this.appRootPath & 'model/';
	this.mappings['/ValidateThis'] = this.appRootPath & 'ValidateThis/ValidateThis/';

	this.datasource = 'dsnReflectiveDiary';

	this.ormenabled = true;
	this.ormsettings = {
		 flushatrequestend = false
		,dbcreate = 'update'
		,automanagesession = false
		,cfclocation = this.mappings['/model']
		,eventhandling = true
		,eventhandler = 'model.aop.GlobalEventHandler'
		// ,logsql = true
		// ,logsql = this.development
		// secondary cache temporarily disabled for application to work in Railo 4
		// bug reported to Railo team - https://issues.jboss.org/browse/RAILO-2233
		//, secondarycacheenabled = true
	};

/*
// create database and populate when the application starts in development environment
// you might want to comment out this code after the initial install

	if( this.development && !isNull( url.rebuild ) ){
		this.ormsettings.dbcreate = 'dropcreate';
		this.ormsettings.sqlscript = '_install/setup.sql';
	}
*/

	setLocale('en_GB');

	variables.framework = {
		// the name of the URL variable:
		// action = 'action'
		// whether or not to use subsystems:
		// usingSubsystems = false,
		// default subsystem name (if usingSubsystems == true):
		// defaultSubsystem = 'home',
		// default section name:
		// defaultSection = 'main'
		// default item name:
		// defaultItem = 'default',
		// if using subsystems, the delimiter between the subsystem and the action:
		// subsystemDelimiter = ':',
		// if using subsystems, the name of the subsystem containing the global layouts:
		// siteWideLayoutSubsystem = 'common',
		// the default when no action is specified:
		// home = defaultSubsystem & ':' & defaultSection & '.' & defaultItem,
		// -- or --
		// home = defaultSection & '.' & defaultItem,
		// the default error action when an exception is thrown:
		// error = defaultSubsystem & ':' & defaultSection & '.error',
		// -- or --
		// error = defaultSection & '.error',
		// the URL variable to reload the controller/service cache:
		// reload = 'reload',
		// the value of the reload variable that authorizes the reload:
		// password = 'true',
		// debugging flag to force reload of cache on each request:
		// reloadApplicationOnEveryRequest = false
		// whether to force generation of SES URLs:
		// generateSES = true,
		// whether to omit /index.cfm in SES URLs:
		// SESOmitIndex = true
		// location used to find layouts / views:
		// base = getDirectoryFromPath( CGI.SCRIPT_NAME ),
		// either CGI.SCRIPT_NAME or a specified base URL path:
		// baseURL = 'useCgiScriptName',
		// location used to find controllers / services:
		// cfcbase = essentially base with / replaced by .
		// whether FW/1 implicit service call should be suppressed:
		// suppressImplicitService = true,
		// list of file extensions that FW/1 should not handle:
		// unhandledExtensions = 'cfc',
		// list of (partial) paths that FW/1 should not handle:
		// unhandledPaths = '/flex2gateway',
		// flash scope magic key and how many concurrent requests are supported:
		// preserveKeyURLKey = 'fw1pk',
		// maxNumContextsPreserved = 10,
		// set this to true to cache the results of fileExists for performance:
		// cacheFileExists = false,
		// change this if you need multiple FW/1 applications in a single CFML application:
		// applicationKey = 'org.corfield.framework'
	};

	public void function setupApplication() {
		ormReload();

		application.appRootPath = this.appRootPath;
		application.webRootPath = this.webRootPath;

		application.cfBootstrap = new com.cfBootstrap.cfBootstrap();

		beanfactory = new org.corfield.ioc('/model', {singletonPattern="(Service|Gateway|DAO|Factory)$"});

		setBeanFactory(beanfactory);

// add cfmlorm DAO factory to the bean factory
		beanFactory.addBean('DAOFactory', new com.cfmlorm.model.abstract.DAOFactory());

		var validatorconfig = {definitionPath='/model/'
			,JSIncludes=false
			,resultPath='model.utility.ValidatorResult'};

// add validator bean to factory
		beanFactory.addBean('Validator', new ValidateThis.ValidateThis(validatorconfig));

		beanFactory.addBean('config', {
			 applicationPasswordSalt = 'BF9BAB6A-EC9B-4C40-BA244DC938395958'
			,security = {
				 resetpasswordemailfrom = ''
				,resetpasswordemailsubject = ''

// list of unsecured actions - by default all requests require authentication
				,whitelist = '^main,^register,^signin,^signout'
			}
		});

		application.remoteBeanFactory = beanFactory;

		return;
	}

	public function getEnvironment() {
		if (reFindNoCase('^*.dev$', CGI.SERVER_NAME)) {
			application.base = 'http://www.infoweb.dev/reflectivediary/';

			variables.framework.reloadApplicationOnEveryRequest = true;

			return 'development';
		} else if (reFindNoCase('^staging.*$', CGI.SERVER_NAME)) {
			application.base = 'http://staging.infoweb.co.uk/reflectivediary/';

			return 'staging';
		} else {
			application.base = 'http://www.infoweb.co.uk/reflectivediary/';

			variables.framework.reload = 'doit';
			variables.framework.password = 'big7boy';

			return 'production';
		}
	}

	function setupRequest() {
		if (NOT structKeyExists(cookie, 'reflectivediary')) {
			cookie name='reflectivediary' value='' preservecase=true;
		}
	}
}