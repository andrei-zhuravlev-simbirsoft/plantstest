--
-- PostgreSQL database dump
--

-- Started on 2010-10-29 14:52:59

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 431 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 410 (class 1247 OID 16593)
-- Dependencies: 3 1640
-- Name: breakpoint; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE breakpoint AS (
	func oid,
	linenumber integer,
	targetname text
);


ALTER TYPE public.breakpoint OWNER TO postgres;

--
-- TOC entry 359 (class 0 OID 0)
-- Name: chkpass; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chkpass;


--
-- TOC entry 20 (class 1255 OID 16404)
-- Dependencies: 3 359
-- Name: chkpass_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chkpass_in(cstring) RETURNS chkpass
    AS '$libdir/chkpass', 'chkpass_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.chkpass_in(cstring) OWNER TO postgres;

--
-- TOC entry 21 (class 1255 OID 16405)
-- Dependencies: 3 359
-- Name: chkpass_out(chkpass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chkpass_out(chkpass) RETURNS cstring
    AS '$libdir/chkpass', 'chkpass_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.chkpass_out(chkpass) OWNER TO postgres;

--
-- TOC entry 358 (class 1247 OID 16403)
-- Dependencies: 20 21 3
-- Name: chkpass; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chkpass (
    INTERNALLENGTH = 16,
    INPUT = chkpass_in,
    OUTPUT = chkpass_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.chkpass OWNER TO postgres;

--
-- TOC entry 1940 (class 0 OID 0)
-- Dependencies: 358
-- Name: TYPE chkpass; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE chkpass IS 'password type with checks';


--
-- TOC entry 412 (class 1247 OID 16596)
-- Dependencies: 3 1641
-- Name: frame; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE frame AS (
	level integer,
	targetname text,
	func oid,
	linenumber integer,
	args text
);


ALTER TYPE public.frame OWNER TO postgres;

--
-- TOC entry 401 (class 0 OID 0)
-- Name: ghstore; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ghstore;


--
-- TOC entry 43 (class 1255 OID 16441)
-- Dependencies: 3 401
-- Name: ghstore_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_in(cstring) RETURNS ghstore
    AS '$libdir/hstore', 'ghstore_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ghstore_in(cstring) OWNER TO postgres;

--
-- TOC entry 44 (class 1255 OID 16442)
-- Dependencies: 3 401
-- Name: ghstore_out(ghstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_out(ghstore) RETURNS cstring
    AS '$libdir/hstore', 'ghstore_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ghstore_out(ghstore) OWNER TO postgres;

--
-- TOC entry 400 (class 1247 OID 16440)
-- Dependencies: 44 43 3
-- Name: ghstore; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ghstore (
    INTERNALLENGTH = variable,
    INPUT = ghstore_in,
    OUTPUT = ghstore_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ghstore OWNER TO postgres;

--
-- TOC entry 398 (class 0 OID 0)
-- Name: hstore; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE hstore;


--
-- TOC entry 25 (class 1255 OID 16413)
-- Dependencies: 3 398
-- Name: hstore_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore_in(cstring) RETURNS hstore
    AS '$libdir/hstore', 'hstore_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.hstore_in(cstring) OWNER TO postgres;

--
-- TOC entry 26 (class 1255 OID 16414)
-- Dependencies: 3 398
-- Name: hstore_out(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore_out(hstore) RETURNS cstring
    AS '$libdir/hstore', 'hstore_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.hstore_out(hstore) OWNER TO postgres;

--
-- TOC entry 397 (class 1247 OID 16412)
-- Dependencies: 26 3 25
-- Name: hstore; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE hstore (
    INTERNALLENGTH = variable,
    INPUT = hstore_in,
    OUTPUT = hstore_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.hstore OWNER TO postgres;

--
-- TOC entry 407 (class 0 OID 0)
-- Name: intbig_gkey; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE intbig_gkey;


--
-- TOC entry 92 (class 1255 OID 16547)
-- Dependencies: 3 407
-- Name: _intbig_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _intbig_in(cstring) RETURNS intbig_gkey
    AS '$libdir/_int', '_intbig_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._intbig_in(cstring) OWNER TO postgres;

--
-- TOC entry 93 (class 1255 OID 16548)
-- Dependencies: 3 407
-- Name: _intbig_out(intbig_gkey); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _intbig_out(intbig_gkey) RETURNS cstring
    AS '$libdir/_int', '_intbig_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._intbig_out(intbig_gkey) OWNER TO postgres;

--
-- TOC entry 406 (class 1247 OID 16546)
-- Dependencies: 93 3 92
-- Name: intbig_gkey; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE intbig_gkey (
    INTERNALLENGTH = variable,
    INPUT = _intbig_in,
    OUTPUT = _intbig_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.intbig_gkey OWNER TO postgres;

--
-- TOC entry 409 (class 1247 OID 16588)
-- Dependencies: 3
-- Name: lo; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN lo AS oid;


ALTER DOMAIN public.lo OWNER TO postgres;

--
-- TOC entry 418 (class 1247 OID 16605)
-- Dependencies: 3 1644
-- Name: proxyinfo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE proxyinfo AS (
	serverversionstr text,
	serverversionnum integer,
	proxyapiver integer,
	serverprocessid integer
);


ALTER TYPE public.proxyinfo OWNER TO postgres;

--
-- TOC entry 404 (class 0 OID 0)
-- Name: query_int; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE query_int;


--
-- TOC entry 58 (class 1255 OID 16479)
-- Dependencies: 3 404
-- Name: bqarr_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bqarr_in(cstring) RETURNS query_int
    AS '$libdir/_int', 'bqarr_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bqarr_in(cstring) OWNER TO postgres;

--
-- TOC entry 59 (class 1255 OID 16480)
-- Dependencies: 3 404
-- Name: bqarr_out(query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bqarr_out(query_int) RETURNS cstring
    AS '$libdir/_int', 'bqarr_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bqarr_out(query_int) OWNER TO postgres;

--
-- TOC entry 403 (class 1247 OID 16478)
-- Dependencies: 59 3 58
-- Name: query_int; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE query_int (
    INTERNALLENGTH = variable,
    INPUT = bqarr_in,
    OUTPUT = bqarr_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.query_int OWNER TO postgres;

--
-- TOC entry 414 (class 1247 OID 16599)
-- Dependencies: 3 1642
-- Name: targetinfo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE targetinfo AS (
	target oid,
	schema oid,
	nargs integer,
	argtypes oidvector,
	targetname name,
	argmodes "char"[],
	argnames text[],
	targetlang oid,
	fqname text,
	returnsset boolean,
	returntype oid
);


ALTER TYPE public.targetinfo OWNER TO postgres;

--
-- TOC entry 416 (class 1247 OID 16602)
-- Dependencies: 3 1643
-- Name: var; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE var AS (
	name text,
	varclass character(1),
	linenumber integer,
	isunique boolean,
	isconst boolean,
	isnotnull boolean,
	dtype oid,
	value text
);


ALTER TYPE public.var OWNER TO postgres;

--
-- TOC entry 64 (class 1255 OID 16488)
-- Dependencies: 3
-- Name: _int_contained(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_contained(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_contained(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1941 (class 0 OID 0)
-- Dependencies: 64
-- Name: FUNCTION _int_contained(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_contained(integer[], integer[]) IS 'contained in';


--
-- TOC entry 63 (class 1255 OID 16487)
-- Dependencies: 3
-- Name: _int_contains(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_contains(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_contains(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1942 (class 0 OID 0)
-- Dependencies: 63
-- Name: FUNCTION _int_contains(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_contains(integer[], integer[]) IS 'contains';


--
-- TOC entry 67 (class 1255 OID 16491)
-- Dependencies: 3
-- Name: _int_different(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_different(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_different'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_different(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1943 (class 0 OID 0)
-- Dependencies: 67
-- Name: FUNCTION _int_different(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_different(integer[], integer[]) IS 'different';


--
-- TOC entry 69 (class 1255 OID 16493)
-- Dependencies: 3
-- Name: _int_inter(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_inter(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', '_int_inter'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_inter(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 65 (class 1255 OID 16489)
-- Dependencies: 3
-- Name: _int_overlap(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_overlap(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_overlap'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_overlap(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1944 (class 0 OID 0)
-- Dependencies: 65
-- Name: FUNCTION _int_overlap(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_overlap(integer[], integer[]) IS 'overlaps';


--
-- TOC entry 66 (class 1255 OID 16490)
-- Dependencies: 3
-- Name: _int_same(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_same(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_same'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_same(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1945 (class 0 OID 0)
-- Dependencies: 66
-- Name: FUNCTION _int_same(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_same(integer[], integer[]) IS 'same as';


--
-- TOC entry 68 (class 1255 OID 16492)
-- Dependencies: 3
-- Name: _int_union(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_union(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', '_int_union'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_union(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 38 (class 1255 OID 16435)
-- Dependencies: 3 397
-- Name: akeys(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION akeys(hstore) RETURNS text[]
    AS '$libdir/hstore', 'akeys'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.akeys(hstore) OWNER TO postgres;

--
-- TOC entry 39 (class 1255 OID 16436)
-- Dependencies: 3 397
-- Name: avals(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION avals(hstore) RETURNS text[]
    AS '$libdir/hstore', 'avals'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.avals(hstore) OWNER TO postgres;

--
-- TOC entry 61 (class 1255 OID 16483)
-- Dependencies: 3 403
-- Name: boolop(integer[], query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION boolop(integer[], query_int) RETURNS boolean
    AS '$libdir/_int', 'boolop'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.boolop(integer[], query_int) OWNER TO postgres;

--
-- TOC entry 1946 (class 0 OID 0)
-- Dependencies: 61
-- Name: FUNCTION boolop(integer[], query_int); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION boolop(integer[], query_int) IS 'boolean operation with array';


--
-- TOC entry 31 (class 1255 OID 16422)
-- Dependencies: 3 397
-- Name: defined(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION defined(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'defined'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.defined(hstore, text) OWNER TO postgres;

--
-- TOC entry 32 (class 1255 OID 16423)
-- Dependencies: 397 3 397
-- Name: delete(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete(hstore, text) RETURNS hstore
    AS '$libdir/hstore', 'delete'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.delete(hstore, text) OWNER TO postgres;

--
-- TOC entry 42 (class 1255 OID 16439)
-- Dependencies: 3 397
-- Name: each(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION each(hs hstore, OUT key text, OUT value text) RETURNS SETOF record
    AS '$libdir/hstore', 'each'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.each(hs hstore, OUT key text, OUT value text) OWNER TO postgres;

--
-- TOC entry 23 (class 1255 OID 16408)
-- Dependencies: 3 358
-- Name: eq(chkpass, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eq(chkpass, text) RETURNS boolean
    AS '$libdir/chkpass', 'chkpass_eq'
    LANGUAGE c STRICT;


ALTER FUNCTION public.eq(chkpass, text) OWNER TO postgres;

--
-- TOC entry 29 (class 1255 OID 16419)
-- Dependencies: 3 397
-- Name: exist(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exist(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'exists'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.exist(hstore, text) OWNER TO postgres;

--
-- TOC entry 27 (class 1255 OID 16416)
-- Dependencies: 397 3
-- Name: fetchval(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fetchval(hstore, text) RETURNS text
    AS '$libdir/hstore', 'fetchval'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.fetchval(hstore, text) OWNER TO postgres;

--
-- TOC entry 86 (class 1255 OID 16524)
-- Dependencies: 3
-- Name: g_int_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_compress(internal) RETURNS internal
    AS '$libdir/_int', 'g_int_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_compress(internal) OWNER TO postgres;

--
-- TOC entry 85 (class 1255 OID 16523)
-- Dependencies: 3
-- Name: g_int_consistent(internal, integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_consistent(internal, integer[], integer) RETURNS boolean
    AS '$libdir/_int', 'g_int_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_consistent(internal, integer[], integer) OWNER TO postgres;

--
-- TOC entry 87 (class 1255 OID 16525)
-- Dependencies: 3
-- Name: g_int_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_decompress(internal) RETURNS internal
    AS '$libdir/_int', 'g_int_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_decompress(internal) OWNER TO postgres;

--
-- TOC entry 88 (class 1255 OID 16526)
-- Dependencies: 3
-- Name: g_int_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_int_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.g_int_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 89 (class 1255 OID 16527)
-- Dependencies: 3
-- Name: g_int_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_picksplit(internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_int_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 91 (class 1255 OID 16529)
-- Dependencies: 3
-- Name: g_int_same(integer[], integer[], internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_same(integer[], integer[], internal) RETURNS internal
    AS '$libdir/_int', 'g_int_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_same(integer[], integer[], internal) OWNER TO postgres;

--
-- TOC entry 90 (class 1255 OID 16528)
-- Dependencies: 3
-- Name: g_int_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_union(internal, internal) RETURNS integer[]
    AS '$libdir/_int', 'g_int_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 95 (class 1255 OID 16551)
-- Dependencies: 3
-- Name: g_intbig_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_compress(internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_compress(internal) OWNER TO postgres;

--
-- TOC entry 94 (class 1255 OID 16550)
-- Dependencies: 3
-- Name: g_intbig_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_consistent(internal, internal, integer) RETURNS boolean
    AS '$libdir/_int', 'g_intbig_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_consistent(internal, internal, integer) OWNER TO postgres;

--
-- TOC entry 96 (class 1255 OID 16552)
-- Dependencies: 3
-- Name: g_intbig_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_decompress(internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_decompress(internal) OWNER TO postgres;

--
-- TOC entry 97 (class 1255 OID 16553)
-- Dependencies: 3
-- Name: g_intbig_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.g_intbig_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 98 (class 1255 OID 16554)
-- Dependencies: 3
-- Name: g_intbig_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_picksplit(internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 100 (class 1255 OID 16556)
-- Dependencies: 3
-- Name: g_intbig_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_same(internal, internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 99 (class 1255 OID 16555)
-- Dependencies: 3
-- Name: g_intbig_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_union(internal, internal) RETURNS integer[]
    AS '$libdir/_int', 'g_intbig_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 45 (class 1255 OID 16444)
-- Dependencies: 3
-- Name: ghstore_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_compress(internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_compress(internal) OWNER TO postgres;

--
-- TOC entry 51 (class 1255 OID 16450)
-- Dependencies: 3
-- Name: ghstore_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_consistent(internal, internal, integer) RETURNS boolean
    AS '$libdir/hstore', 'ghstore_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_consistent(internal, internal, integer) OWNER TO postgres;

--
-- TOC entry 46 (class 1255 OID 16445)
-- Dependencies: 3
-- Name: ghstore_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_decompress(internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_decompress(internal) OWNER TO postgres;

--
-- TOC entry 47 (class 1255 OID 16446)
-- Dependencies: 3
-- Name: ghstore_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ghstore_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 48 (class 1255 OID 16447)
-- Dependencies: 3
-- Name: ghstore_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_picksplit(internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 50 (class 1255 OID 16449)
-- Dependencies: 3
-- Name: ghstore_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_same(internal, internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 49 (class 1255 OID 16448)
-- Dependencies: 3
-- Name: ghstore_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_union(internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 54 (class 1255 OID 16465)
-- Dependencies: 3
-- Name: gin_consistent_hstore(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_consistent_hstore(internal, smallint, internal) RETURNS internal
    AS '$libdir/hstore', 'gin_consistent_hstore'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_consistent_hstore(internal, smallint, internal) OWNER TO postgres;

--
-- TOC entry 52 (class 1255 OID 16463)
-- Dependencies: 3
-- Name: gin_extract_hstore(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_hstore(internal, internal) RETURNS internal
    AS '$libdir/hstore', 'gin_extract_hstore'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_extract_hstore(internal, internal) OWNER TO postgres;

--
-- TOC entry 53 (class 1255 OID 16464)
-- Dependencies: 3
-- Name: gin_extract_hstore_query(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_hstore_query(internal, internal, smallint) RETURNS internal
    AS '$libdir/hstore', 'gin_extract_hstore_query'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_extract_hstore_query(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 102 (class 1255 OID 16574)
-- Dependencies: 3
-- Name: ginint4_consistent(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ginint4_consistent(internal, smallint, internal) RETURNS internal
    AS '$libdir/_int', 'ginint4_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ginint4_consistent(internal, smallint, internal) OWNER TO postgres;

--
-- TOC entry 101 (class 1255 OID 16573)
-- Dependencies: 3
-- Name: ginint4_queryextract(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ginint4_queryextract(internal, internal, smallint) RETURNS internal
    AS '$libdir/_int', 'ginint4_queryextract'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ginint4_queryextract(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 33 (class 1255 OID 16424)
-- Dependencies: 397 397 3 397
-- Name: hs_concat(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_concat(hstore, hstore) RETURNS hstore
    AS '$libdir/hstore', 'hs_concat'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hs_concat(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 35 (class 1255 OID 16427)
-- Dependencies: 3 397 397
-- Name: hs_contained(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_contained(hstore, hstore) RETURNS boolean
    AS '$libdir/hstore', 'hs_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hs_contained(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 34 (class 1255 OID 16426)
-- Dependencies: 397 397 3
-- Name: hs_contains(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_contains(hstore, hstore) RETURNS boolean
    AS '$libdir/hstore', 'hs_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hs_contains(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 37 (class 1255 OID 16433)
-- Dependencies: 397 3
-- Name: hstore(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore(text, text) RETURNS hstore
    AS '$libdir/hstore', 'tconvert'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.hstore(text, text) OWNER TO postgres;

--
-- TOC entry 71 (class 1255 OID 16500)
-- Dependencies: 3
-- Name: icount(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION icount(integer[]) RETURNS integer
    AS '$libdir/_int', 'icount'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.icount(integer[]) OWNER TO postgres;

--
-- TOC entry 77 (class 1255 OID 16507)
-- Dependencies: 3
-- Name: idx(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION idx(integer[], integer) RETURNS integer
    AS '$libdir/_int', 'idx'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.idx(integer[], integer) OWNER TO postgres;

--
-- TOC entry 56 (class 1255 OID 16475)
-- Dependencies: 3
-- Name: int_agg_final_array(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION int_agg_final_array(integer[]) RETURNS integer[]
    AS '$libdir/int_aggregate', 'int_agg_final_array'
    LANGUAGE c;


ALTER FUNCTION public.int_agg_final_array(integer[]) OWNER TO postgres;

--
-- TOC entry 55 (class 1255 OID 16474)
-- Dependencies: 3
-- Name: int_agg_state(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION int_agg_state(integer[], integer) RETURNS integer[]
    AS '$libdir/int_aggregate', 'int_agg_state'
    LANGUAGE c;


ALTER FUNCTION public.int_agg_state(integer[], integer) OWNER TO postgres;

--
-- TOC entry 57 (class 1255 OID 16477)
-- Dependencies: 3
-- Name: int_array_enum(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION int_array_enum(integer[]) RETURNS SETOF integer
    AS '$libdir/int_aggregate', 'int_enum'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.int_array_enum(integer[]) OWNER TO postgres;

--
-- TOC entry 82 (class 1255 OID 16515)
-- Dependencies: 3
-- Name: intarray_del_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_del_elem(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'intarray_del_elem'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intarray_del_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 81 (class 1255 OID 16513)
-- Dependencies: 3
-- Name: intarray_push_array(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_push_array(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', 'intarray_push_array'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intarray_push_array(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 80 (class 1255 OID 16511)
-- Dependencies: 3
-- Name: intarray_push_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_push_elem(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'intarray_push_elem'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intarray_push_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 70 (class 1255 OID 16499)
-- Dependencies: 3
-- Name: intset(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset(integer) RETURNS integer[]
    AS '$libdir/_int', 'intset'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intset(integer) OWNER TO postgres;

--
-- TOC entry 84 (class 1255 OID 16520)
-- Dependencies: 3
-- Name: intset_subtract(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset_subtract(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', 'intset_subtract'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intset_subtract(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 83 (class 1255 OID 16517)
-- Dependencies: 3
-- Name: intset_union_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset_union_elem(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'intset_union_elem'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intset_union_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 30 (class 1255 OID 16421)
-- Dependencies: 3 397
-- Name: isdefined(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isdefined(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'defined'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isdefined(hstore, text) OWNER TO postgres;

--
-- TOC entry 28 (class 1255 OID 16418)
-- Dependencies: 397 3
-- Name: isexists(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isexists(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'exists'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isexists(hstore, text) OWNER TO postgres;

--
-- TOC entry 104 (class 1255 OID 16590)
-- Dependencies: 3
-- Name: lo_manage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lo_manage() RETURNS trigger
    AS '$libdir/lo', 'lo_manage'
    LANGUAGE c;


ALTER FUNCTION public.lo_manage() OWNER TO postgres;

--
-- TOC entry 103 (class 1255 OID 16589)
-- Dependencies: 3 409
-- Name: lo_oid(lo); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lo_oid(lo) RETURNS oid
    AS $_$SELECT $1::pg_catalog.oid$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.lo_oid(lo) OWNER TO postgres;

--
-- TOC entry 24 (class 1255 OID 16409)
-- Dependencies: 358 3
-- Name: ne(chkpass, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ne(chkpass, text) RETURNS boolean
    AS '$libdir/chkpass', 'chkpass_ne'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ne(chkpass, text) OWNER TO postgres;

--
-- TOC entry 106 (class 1255 OID 16607)
-- Dependencies: 3
-- Name: pldbg_abort_target(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_abort_target(session integer) RETURNS SETOF boolean
    AS '$libdir/pldbgapi', 'pldbg_abort_target'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_abort_target(session integer) OWNER TO postgres;

--
-- TOC entry 107 (class 1255 OID 16608)
-- Dependencies: 3
-- Name: pldbg_attach_to_port(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_attach_to_port(portnumber integer) RETURNS integer
    AS '$libdir/pldbgapi', 'pldbg_attach_to_port'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_attach_to_port(portnumber integer) OWNER TO postgres;

--
-- TOC entry 108 (class 1255 OID 16609)
-- Dependencies: 410 3
-- Name: pldbg_continue(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_continue(session integer) RETURNS breakpoint
    AS '$libdir/pldbgapi', 'pldbg_continue'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_continue(session integer) OWNER TO postgres;

--
-- TOC entry 109 (class 1255 OID 16610)
-- Dependencies: 3
-- Name: pldbg_create_listener(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_create_listener() RETURNS integer
    AS '$libdir/pldbgapi', 'pldbg_create_listener'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_create_listener() OWNER TO postgres;

--
-- TOC entry 110 (class 1255 OID 16611)
-- Dependencies: 3
-- Name: pldbg_deposit_value(integer, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_deposit_value(session integer, varname text, linenumber integer, value text) RETURNS boolean
    AS '$libdir/pldbgapi', 'pldbg_deposit_value'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_deposit_value(session integer, varname text, linenumber integer, value text) OWNER TO postgres;

--
-- TOC entry 111 (class 1255 OID 16612)
-- Dependencies: 3
-- Name: pldbg_drop_breakpoint(integer, oid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_drop_breakpoint(session integer, func oid, linenumber integer) RETURNS boolean
    AS '$libdir/pldbgapi', 'pldbg_drop_breakpoint'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_drop_breakpoint(session integer, func oid, linenumber integer) OWNER TO postgres;

--
-- TOC entry 112 (class 1255 OID 16613)
-- Dependencies: 3 410
-- Name: pldbg_get_breakpoints(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_breakpoints(session integer) RETURNS SETOF breakpoint
    AS '$libdir/pldbgapi', 'pldbg_get_breakpoints'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_get_breakpoints(session integer) OWNER TO postgres;

--
-- TOC entry 115 (class 1255 OID 16616)
-- Dependencies: 418 3
-- Name: pldbg_get_proxy_info(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_proxy_info() RETURNS proxyinfo
    AS '$libdir/pldbgapi', 'pldbg_get_proxy_info'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_get_proxy_info() OWNER TO postgres;

--
-- TOC entry 113 (class 1255 OID 16614)
-- Dependencies: 3
-- Name: pldbg_get_source(integer, oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_source(session integer, func oid) RETURNS text
    AS '$libdir/pldbgapi', 'pldbg_get_source'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_get_source(session integer, func oid) OWNER TO postgres;

--
-- TOC entry 114 (class 1255 OID 16615)
-- Dependencies: 412 3
-- Name: pldbg_get_stack(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_stack(session integer) RETURNS SETOF frame
    AS '$libdir/pldbgapi', 'pldbg_get_stack'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_get_stack(session integer) OWNER TO postgres;

--
-- TOC entry 124 (class 1255 OID 16625)
-- Dependencies: 414 3
-- Name: pldbg_get_target_info(text, "char"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_target_info(signature text, targettype "char") RETURNS targetinfo
    AS '$libdir/targetinfo', 'pldbg_get_target_info'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_get_target_info(signature text, targettype "char") OWNER TO postgres;

--
-- TOC entry 116 (class 1255 OID 16617)
-- Dependencies: 416 3
-- Name: pldbg_get_variables(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_variables(session integer) RETURNS SETOF var
    AS '$libdir/pldbgapi', 'pldbg_get_variables'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_get_variables(session integer) OWNER TO postgres;

--
-- TOC entry 117 (class 1255 OID 16618)
-- Dependencies: 410 3
-- Name: pldbg_select_frame(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_select_frame(session integer, frame integer) RETURNS breakpoint
    AS '$libdir/pldbgapi', 'pldbg_select_frame'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_select_frame(session integer, frame integer) OWNER TO postgres;

--
-- TOC entry 118 (class 1255 OID 16619)
-- Dependencies: 3
-- Name: pldbg_set_breakpoint(integer, oid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_set_breakpoint(session integer, func oid, linenumber integer) RETURNS boolean
    AS '$libdir/pldbgapi', 'pldbg_set_breakpoint'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_set_breakpoint(session integer, func oid, linenumber integer) OWNER TO postgres;

--
-- TOC entry 119 (class 1255 OID 16620)
-- Dependencies: 3
-- Name: pldbg_set_global_breakpoint(integer, oid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_set_global_breakpoint(session integer, func oid, linenumber integer, targetpid integer) RETURNS boolean
    AS '$libdir/pldbgapi', 'pldbg_set_global_breakpoint'
    LANGUAGE c;


ALTER FUNCTION public.pldbg_set_global_breakpoint(session integer, func oid, linenumber integer, targetpid integer) OWNER TO postgres;

--
-- TOC entry 120 (class 1255 OID 16621)
-- Dependencies: 3 410
-- Name: pldbg_step_into(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_step_into(session integer) RETURNS breakpoint
    AS '$libdir/pldbgapi', 'pldbg_step_into'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_step_into(session integer) OWNER TO postgres;

--
-- TOC entry 121 (class 1255 OID 16622)
-- Dependencies: 3 410
-- Name: pldbg_step_over(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_step_over(session integer) RETURNS breakpoint
    AS '$libdir/pldbgapi', 'pldbg_step_over'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_step_over(session integer) OWNER TO postgres;

--
-- TOC entry 122 (class 1255 OID 16623)
-- Dependencies: 3 410
-- Name: pldbg_wait_for_breakpoint(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_wait_for_breakpoint(session integer) RETURNS breakpoint
    AS '$libdir/pldbgapi', 'pldbg_wait_for_breakpoint'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_wait_for_breakpoint(session integer) OWNER TO postgres;

--
-- TOC entry 123 (class 1255 OID 16624)
-- Dependencies: 3
-- Name: pldbg_wait_for_target(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_wait_for_target(session integer) RETURNS integer
    AS '$libdir/pldbgapi', 'pldbg_wait_for_target'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pldbg_wait_for_target(session integer) OWNER TO postgres;

--
-- TOC entry 105 (class 1255 OID 16606)
-- Dependencies: 3
-- Name: plpgsql_oid_debug(oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plpgsql_oid_debug(functionoid oid) RETURNS integer
    AS '$libdir/plugins/plugin_debugger', 'plpgsql_oid_debug'
    LANGUAGE c STRICT;


ALTER FUNCTION public.plpgsql_oid_debug(functionoid oid) OWNER TO postgres;

--
-- TOC entry 60 (class 1255 OID 16482)
-- Dependencies: 3 403
-- Name: querytree(query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION querytree(query_int) RETURNS text
    AS '$libdir/_int', 'querytree'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.querytree(query_int) OWNER TO postgres;

--
-- TOC entry 22 (class 1255 OID 16407)
-- Dependencies: 3 358
-- Name: raw(chkpass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION raw(chkpass) RETURNS text
    AS '$libdir/chkpass', 'chkpass_rout'
    LANGUAGE c STRICT;


ALTER FUNCTION public.raw(chkpass) OWNER TO postgres;

--
-- TOC entry 62 (class 1255 OID 16484)
-- Dependencies: 403 3
-- Name: rboolop(query_int, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rboolop(query_int, integer[]) RETURNS boolean
    AS '$libdir/_int', 'rboolop'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rboolop(query_int, integer[]) OWNER TO postgres;

--
-- TOC entry 1947 (class 0 OID 0)
-- Dependencies: 62
-- Name: FUNCTION rboolop(query_int, integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION rboolop(query_int, integer[]) IS 'boolean operation with array';


--
-- TOC entry 40 (class 1255 OID 16437)
-- Dependencies: 397 3
-- Name: skeys(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION skeys(hstore) RETURNS SETOF text
    AS '$libdir/hstore', 'skeys'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.skeys(hstore) OWNER TO postgres;

--
-- TOC entry 72 (class 1255 OID 16502)
-- Dependencies: 3
-- Name: sort(integer[], text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort(integer[], text) RETURNS integer[]
    AS '$libdir/_int', 'sort'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort(integer[], text) OWNER TO postgres;

--
-- TOC entry 73 (class 1255 OID 16503)
-- Dependencies: 3
-- Name: sort(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'sort'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort(integer[]) OWNER TO postgres;

--
-- TOC entry 74 (class 1255 OID 16504)
-- Dependencies: 3
-- Name: sort_asc(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort_asc(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'sort_asc'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort_asc(integer[]) OWNER TO postgres;

--
-- TOC entry 75 (class 1255 OID 16505)
-- Dependencies: 3
-- Name: sort_desc(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort_desc(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'sort_desc'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort_desc(integer[]) OWNER TO postgres;

--
-- TOC entry 78 (class 1255 OID 16509)
-- Dependencies: 3
-- Name: subarray(integer[], integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subarray(integer[], integer, integer) RETURNS integer[]
    AS '$libdir/_int', 'subarray'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subarray(integer[], integer, integer) OWNER TO postgres;

--
-- TOC entry 79 (class 1255 OID 16510)
-- Dependencies: 3
-- Name: subarray(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subarray(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'subarray'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subarray(integer[], integer) OWNER TO postgres;

--
-- TOC entry 41 (class 1255 OID 16438)
-- Dependencies: 3 397
-- Name: svals(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION svals(hstore) RETURNS SETOF text
    AS '$libdir/hstore', 'svals'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.svals(hstore) OWNER TO postgres;

--
-- TOC entry 36 (class 1255 OID 16432)
-- Dependencies: 397 3
-- Name: tconvert(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tconvert(text, text) RETURNS hstore
    AS '$libdir/hstore', 'tconvert'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.tconvert(text, text) OWNER TO postgres;

--
-- TOC entry 76 (class 1255 OID 16506)
-- Dependencies: 3
-- Name: uniq(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uniq(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'uniq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.uniq(integer[]) OWNER TO postgres;

--
-- TOC entry 432 (class 1255 OID 16476)
-- Dependencies: 3 55 56
-- Name: int_array_aggregate(integer); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE int_array_aggregate(integer) (
    SFUNC = int_agg_state,
    STYPE = integer[],
    FINALFUNC = int_agg_final_array
);


ALTER AGGREGATE public.int_array_aggregate(integer) OWNER TO postgres;

--
-- TOC entry 1152 (class 2617 OID 16501)
-- Dependencies: 3 71
-- Name: #; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR # (
    PROCEDURE = icount,
    RIGHTARG = integer[]
);


ALTER OPERATOR public.# (NONE, integer[]) OWNER TO postgres;

--
-- TOC entry 1153 (class 2617 OID 16508)
-- Dependencies: 3 77
-- Name: #; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR # (
    PROCEDURE = idx,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.# (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1160 (class 2617 OID 16522)
-- Dependencies: 69 3
-- Name: &; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR & (
    PROCEDURE = _int_inter,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &
);


ALTER OPERATOR public.& (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1147 (class 2617 OID 16494)
-- Dependencies: 65 3
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = _int_overlap,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.&& (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1154 (class 2617 OID 16512)
-- Dependencies: 80 3
-- Name: +; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.+ (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1155 (class 2617 OID 16514)
-- Dependencies: 3 81
-- Name: +; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_array,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = +
);


ALTER OPERATOR public.+ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1156 (class 2617 OID 16516)
-- Dependencies: 3 82
-- Name: -; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR - (
    PROCEDURE = intarray_del_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.- (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1159 (class 2617 OID 16521)
-- Dependencies: 84 3
-- Name: -; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR - (
    PROCEDURE = intset_subtract,
    LEFTARG = integer[],
    RIGHTARG = integer[]
);


ALTER OPERATOR public.- (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1137 (class 2617 OID 16417)
-- Dependencies: 397 3 27
-- Name: ->; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR -> (
    PROCEDURE = fetchval,
    LEFTARG = hstore,
    RIGHTARG = text
);


ALTER OPERATOR public.-> (hstore, text) OWNER TO postgres;

--
-- TOC entry 1136 (class 2617 OID 16410)
-- Dependencies: 3 358 24
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = ne,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = =
);


ALTER OPERATOR public.<> (chkpass, text) OWNER TO postgres;

--
-- TOC entry 1141 (class 2617 OID 16428)
-- Dependencies: 397 35 397 3
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 1149 (class 2617 OID 16495)
-- Dependencies: 3 64
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1135 (class 2617 OID 16411)
-- Dependencies: 3 23 358
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = eq,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = <>
);


ALTER OPERATOR public.= (chkpass, text) OWNER TO postgres;

--
-- TOC entry 1144 (class 2617 OID 16434)
-- Dependencies: 397 3 36
-- Name: =>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR => (
    PROCEDURE = tconvert,
    LEFTARG = text,
    RIGHTARG = text
);


ALTER OPERATOR public.=> (text, text) OWNER TO postgres;

--
-- TOC entry 1138 (class 2617 OID 16420)
-- Dependencies: 29 3 397
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = exist,
    LEFTARG = hstore,
    RIGHTARG = text,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (hstore, text) OWNER TO postgres;

--
-- TOC entry 1142 (class 2617 OID 16431)
-- Dependencies: 397 397 34 3
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 1150 (class 2617 OID 16498)
-- Dependencies: 3 63
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1140 (class 2617 OID 16429)
-- Dependencies: 34 397 3 397
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 1148 (class 2617 OID 16496)
-- Dependencies: 3 63
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1145 (class 2617 OID 16486)
-- Dependencies: 403 61 3
-- Name: @@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @@ (
    PROCEDURE = boolop,
    LEFTARG = integer[],
    RIGHTARG = query_int,
    COMMUTATOR = ~~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (integer[], query_int) OWNER TO postgres;

--
-- TOC entry 1157 (class 2617 OID 16518)
-- Dependencies: 83 3
-- Name: |; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR | (
    PROCEDURE = intset_union_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.| (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1158 (class 2617 OID 16519)
-- Dependencies: 68 3
-- Name: |; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR | (
    PROCEDURE = _int_union,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = |
);


ALTER OPERATOR public.| (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1139 (class 2617 OID 16425)
-- Dependencies: 3 397 397 397 33
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = hs_concat,
    LEFTARG = hstore,
    RIGHTARG = hstore
);


ALTER OPERATOR public.|| (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 1143 (class 2617 OID 16430)
-- Dependencies: 35 397 3 397
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 1151 (class 2617 OID 16497)
-- Dependencies: 64 3
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1146 (class 2617 OID 16485)
-- Dependencies: 3 403 62
-- Name: ~~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~~ (
    PROCEDURE = rboolop,
    LEFTARG = query_int,
    RIGHTARG = integer[],
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~~ (query_int, integer[]) OWNER TO postgres;

--
-- TOC entry 1277 (class 2616 OID 16576)
-- Dependencies: 3 1389
-- Name: gin__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin__int_ops
    FOR TYPE integer[] USING gin AS
    STORAGE integer ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) RECHECK ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) RECHECK ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) RECHECK ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 ginarrayextract(anyarray,internal) ,
    FUNCTION 3 ginint4_queryextract(internal,internal,smallint) ,
    FUNCTION 4 ginint4_consistent(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin__int_ops USING gin OWNER TO postgres;

--
-- TOC entry 1274 (class 2616 OID 16467)
-- Dependencies: 1386 3 397
-- Name: gin_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin_hstore_ops
    DEFAULT FOR TYPE hstore USING gin AS
    STORAGE text ,
    OPERATOR 7 @>(hstore,hstore) RECHECK ,
    OPERATOR 9 ?(hstore,text) ,
    FUNCTION 1 bttextcmp(text,text) ,
    FUNCTION 2 gin_extract_hstore(internal,internal) ,
    FUNCTION 3 gin_extract_hstore_query(internal,internal,smallint) ,
    FUNCTION 4 gin_consistent_hstore(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin_hstore_ops USING gin OWNER TO postgres;

--
-- TOC entry 1275 (class 2616 OID 16531)
-- Dependencies: 3 1387
-- Name: gist__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__int_ops
    DEFAULT FOR TYPE integer[] USING gist AS
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) RECHECK ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_int_consistent(internal,integer[],integer) ,
    FUNCTION 2 g_int_union(internal,internal) ,
    FUNCTION 3 g_int_compress(internal) ,
    FUNCTION 4 g_int_decompress(internal) ,
    FUNCTION 5 g_int_penalty(internal,internal,internal) ,
    FUNCTION 6 g_int_picksplit(internal,internal) ,
    FUNCTION 7 g_int_same(integer[],integer[],internal);


ALTER OPERATOR CLASS public.gist__int_ops USING gist OWNER TO postgres;

--
-- TOC entry 1276 (class 2616 OID 16558)
-- Dependencies: 406 3 1388
-- Name: gist__intbig_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__intbig_ops
    FOR TYPE integer[] USING gist AS
    STORAGE intbig_gkey ,
    OPERATOR 3 &&(integer[],integer[]) RECHECK ,
    OPERATOR 6 =(anyarray,anyarray) RECHECK ,
    OPERATOR 7 @>(integer[],integer[]) RECHECK ,
    OPERATOR 8 <@(integer[],integer[]) RECHECK ,
    OPERATOR 13 @(integer[],integer[]) RECHECK ,
    OPERATOR 14 ~(integer[],integer[]) RECHECK ,
    OPERATOR 20 @@(integer[],query_int) RECHECK ,
    FUNCTION 1 g_intbig_consistent(internal,internal,integer) ,
    FUNCTION 2 g_intbig_union(internal,internal) ,
    FUNCTION 3 g_intbig_compress(internal) ,
    FUNCTION 4 g_intbig_decompress(internal) ,
    FUNCTION 5 g_intbig_penalty(internal,internal,internal) ,
    FUNCTION 6 g_intbig_picksplit(internal,internal) ,
    FUNCTION 7 g_intbig_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__intbig_ops USING gist OWNER TO postgres;

--
-- TOC entry 1273 (class 2616 OID 16452)
-- Dependencies: 400 3 1385 397
-- Name: gist_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_hstore_ops
    DEFAULT FOR TYPE hstore USING gist AS
    STORAGE ghstore ,
    OPERATOR 7 @>(hstore,hstore) RECHECK ,
    OPERATOR 9 ?(hstore,text) RECHECK ,
    OPERATOR 13 @(hstore,hstore) RECHECK ,
    FUNCTION 1 ghstore_consistent(internal,internal,integer) ,
    FUNCTION 2 ghstore_union(internal,internal) ,
    FUNCTION 3 ghstore_compress(internal) ,
    FUNCTION 4 ghstore_decompress(internal) ,
    FUNCTION 5 ghstore_penalty(internal,internal,internal) ,
    FUNCTION 6 ghstore_picksplit(internal,internal) ,
    FUNCTION 7 ghstore_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_hstore_ops USING gist OWNER TO postgres;

--
-- TOC entry 1651 (class 1259 OID 16655)
-- Dependencies: 3
-- Name: field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE field_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.field_id_seq OWNER TO postgres;

--
-- TOC entry 1948 (class 0 OID 0)
-- Dependencies: 1651
-- Name: field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('field_id_seq', 63, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1650 (class 1259 OID 16648)
-- Dependencies: 1920 3
-- Name: field; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field (
    id integer DEFAULT nextval('field_id_seq'::regclass) NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    plant_id integer NOT NULL,
    state_id integer NOT NULL
);


ALTER TABLE public.field OWNER TO postgres;

--
-- TOC entry 1647 (class 1259 OID 16633)
-- Dependencies: 3
-- Name: plant_states; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plant_states (
    plant_id integer NOT NULL,
    state_id integer NOT NULL,
    level integer,
    sprite_name character varying(200)
);


ALTER TABLE public.plant_states OWNER TO postgres;

--
-- TOC entry 1646 (class 1259 OID 16629)
-- Dependencies: 3
-- Name: plants; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plants (
    plant_id integer NOT NULL,
    name character varying(200)
);


ALTER TABLE public.plants OWNER TO postgres;

--
-- TOC entry 1645 (class 1259 OID 16627)
-- Dependencies: 3 1646
-- Name: plants_plant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE plants_plant_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.plants_plant_id_seq OWNER TO postgres;

--
-- TOC entry 1949 (class 0 OID 0)
-- Dependencies: 1645
-- Name: plants_plant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE plants_plant_id_seq OWNED BY plants.plant_id;


--
-- TOC entry 1950 (class 0 OID 0)
-- Dependencies: 1645
-- Name: plants_plant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('plants_plant_id_seq', 5, true);


--
-- TOC entry 1649 (class 1259 OID 16638)
-- Dependencies: 3
-- Name: states; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE states (
    state_id integer NOT NULL,
    name character varying(200)
);


ALTER TABLE public.states OWNER TO postgres;

--
-- TOC entry 1648 (class 1259 OID 16636)
-- Dependencies: 3 1649
-- Name: states_state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE states_state_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.states_state_id_seq OWNER TO postgres;

--
-- TOC entry 1951 (class 0 OID 0)
-- Dependencies: 1648
-- Name: states_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE states_state_id_seq OWNED BY states.state_id;


--
-- TOC entry 1952 (class 0 OID 0)
-- Dependencies: 1648
-- Name: states_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('states_state_id_seq', 15, true);


--
-- TOC entry 1918 (class 2604 OID 16632)
-- Dependencies: 1645 1646 1646
-- Name: plant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE plants ALTER COLUMN plant_id SET DEFAULT nextval('plants_plant_id_seq'::regclass);


--
-- TOC entry 1919 (class 2604 OID 16641)
-- Dependencies: 1649 1648 1649
-- Name: state_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE states ALTER COLUMN state_id SET DEFAULT nextval('states_state_id_seq'::regclass);


--
-- TOC entry 1934 (class 0 OID 16648)
-- Dependencies: 1650
-- Data for Name: field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY field (id, x, y, plant_id, state_id) FROM stdin;
63	5	5	2	1
\.


--
-- TOC entry 1932 (class 0 OID 16633)
-- Dependencies: 1647
-- Data for Name: plant_states; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY plant_states (plant_id, state_id, level, sprite_name) FROM stdin;
2	1	1	Image 1.png
2	3	3	Image 5.png
2	4	4	Image 7.png
2	5	5	Image 9.png
2	2	2	Image 3.png
3	7	2	Image 3.png
3	8	3	Image 5.png
4	11	1	Image 1.png
4	12	2	Image 3.png
4	13	3	Image 5.png
4	14	4	Image 7.png
4	15	5	Image 9.png
3	6	1	Image 1.png
3	9	4	Image 7.png
3	10	5	Image 8.png
\.


--
-- TOC entry 1931 (class 0 OID 16629)
-- Dependencies: 1646
-- Data for Name: plants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY plants (plant_id, name) FROM stdin;
2	clover
3	potato
4	sunflower
\.


--
-- TOC entry 1933 (class 0 OID 16638)
-- Dependencies: 1649
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY states (state_id, name) FROM stdin;
1	\N
2	\N
3	\N
4	\N
5	\N
6	\N
7	\N
8	\N
9	\N
10	\N
11	\N
12	\N
13	\N
14	\N
15	\N
16	\N
17	\N
18	\N
19	\N
20	\N
\.


--
-- TOC entry 1928 (class 2606 OID 16652)
-- Dependencies: 1650 1650
-- Name: field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field
    ADD CONSTRAINT field_pkey PRIMARY KEY (id);


--
-- TOC entry 1930 (class 2606 OID 16665)
-- Dependencies: 1650 1650 1650
-- Name: field_x_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field
    ADD CONSTRAINT field_x_key UNIQUE (x, y);


--
-- TOC entry 1924 (class 2606 OID 16659)
-- Dependencies: 1647 1647 1647
-- Name: p; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plant_states
    ADD CONSTRAINT p PRIMARY KEY (plant_id, state_id);


--
-- TOC entry 1922 (class 2606 OID 16643)
-- Dependencies: 1646 1646
-- Name: plant_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plants
    ADD CONSTRAINT plant_id_pk PRIMARY KEY (plant_id);


--
-- TOC entry 1926 (class 2606 OID 16645)
-- Dependencies: 1649 1649
-- Name: state_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY states
    ADD CONSTRAINT state_id_pk PRIMARY KEY (state_id);


--
-- TOC entry 1939 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-10-29 14:53:01

--
-- PostgreSQL database dump complete
--

