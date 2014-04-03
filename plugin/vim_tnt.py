import json
from urllib import quote as uquote
from urllib import unquote as uunquote
from urllib import quote_plus as uquote_plus
from urllib import unquote_plus as uunquote_plus


def format_json(js_text):
    res = json.loads(js_text)
    return json.dumps(res, sort_keys=True, indent=4).split('\n')


def quote(s):
    """calls urllib.quote, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uquote(s.encode('utf-8'))
        else:
            return uquote(s)
    return None


def quote_plus(s):
    """calls urllib.quote_plus, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uquote_plus(s.encode('utf-8'))
        else:
            return uquote_plus(s)
    return None


def unquote(s):
    """calls urllib.unquote, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uunquote(s.encode('utf-8'))
        else:
            return uunquote(s)
    return None


def unquote_plus(s):
    """calls urllib.unquote_plus, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uunquote_plus(s.encode('utf-8'))
        else:
            return uunquote_plus(s)
    return None
