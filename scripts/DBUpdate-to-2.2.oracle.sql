-- --
-- Update an existing OTRS database from 2.1 to 2.2
-- Copyright (C) 2001-2006 OTRS GmbH, http://otrs.org/
-- --
-- $Id: DBUpdate-to-2.2.oracle.sql,v 1.2 2007-01-30 12:28:15 mh Exp $
-- --
--
-- usage: cat DBUpdate-to-2.2.oracle.sql | sqlplus "user/password"
--
-- --

--
-- ticket_priority
--
ALTER TABLE ticket_priority ADD valid_id INTEGER;
UPDATE ticket_priority SET valid_id = 1;

