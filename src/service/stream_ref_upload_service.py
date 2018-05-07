#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""
# ----------------------------------------------------------
#  Copyright (python) ,2016-2036, Sowell Tech. Co,Ltd
#  FileName: service.__init__.py
#  Author: RVmanage
#  Email: info@sowell-tech.com
#  Version: 0.0.1
#  LastChange: 2017-03-17
#  History: modified by  tumin
#  Desc:
# ----------------------------------------------------------
"""
import traceback

from dao import Session
from database import StreamingUpload
from utils.globals import runlog

def _insert(data):
    t_serverupload = StreamingUpload()
    result = {'errorcode': -1}
    t_serverupload.insert(data)
    result = {'errorcode': 0}
    return result


def record_stream_refupload(values):
    """
    record streaming relevant service
    """
    return_code = 0
    try:
        params = {'channel_id': values['channel_id']}
        for value_ser in values['upload_id_list']:
            params['upload_id'] = value_ser
            re = _insert(params)
            params.pop("upload_id")
            if re['errorcode'] == -1:
                return_code = 1001

    except Exception:
        return_code = 500
        runlog.error(traceback.format_exc())

    finally:

        return return_code

def get_record_stream_refupload(get_info):
    """
    :param get_info:
    """
    return_code = 0
    session = Session()
    lst_info = []
    res = {}
    try:
        t_serverupload = StreamingUpload()
        res = {}
        params = {"filters": []}
        if 'channel_id' in get_info.keys():
            params["filters"].append({"op": "==", "value": get_info["channel_id"], "name": "channel_id"})
        lst_info = t_serverupload.all(**params)
    except Exception:
        return_code = 1001
        runlog.error(traceback.format_exc())
    finally:
        session.close()
        if len(lst_info) != 0:
            res["total_size"] = len(lst_info)
            res['ref_list'] = lst_info
            return return_code, res
        else:
            return return_code, None

def delete_stream_refupload(values):
    """
    :param values:
    """
    return_code = 0
    session = Session()
    try:
        t_serverupload = StreamingUpload()
        params = {'channel_id': values['channel_id'][0]}
        for id_item in values['upload_id_list']:
            params['upload_id'] = id_item
            lst_info = t_serverupload.all(**params)
            if len(lst_info) == 0:
                return_code = 1001
            else:
                result = t_serverupload.delete(**params)
                return_code = 0
                if result == 0:
                    return_code = 1001
                lst_info = t_serverupload.all(**params)
                if len(lst_info) == 0:
                    return_code = 0

    except Exception:
        return_code = 500
        runlog.error(traceback.format_exc())

    finally:
        session.close()
        return return_code
