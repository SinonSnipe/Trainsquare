import React, { useState, useEffect } from 'react';
import { ZoomMtg } from '@zoomus/websdk';
import debug from 'sabio-debug';
import { useLocation } from 'react-router-dom';

const _logger = debug.extend('Zoom');

function ZoomStream() {
    const [meeting, setMeeting] = useState({
        sdkKey: 'L5cmLNTWbU71sKiKqDiUd7WBvpzrEdB0R79w',
        signature: '',
        meetingNumber: '',
        passWord: '',
        userName: '',
        zak: null,
    });

    const [zoomReady, setZoomReady] = useState(false);

    const { state } = useLocation();

    useEffect(() => {
        if (state?.type === 'ZOOM_DATA' && state.payload) {
            setMeeting((prevState) => {
                const md = { ...prevState };
                md.signature = state.payload.signature;
                md.meetingNumber = state.payload.meetingNumber;
                md.passWord = state.payload.passWord;
                md.userName = state.payload.userName;
                md.zak = state.payload.zak || null;
                return md;
            });

            setZoomReady(true);
        }
    }, [state]);

    if (zoomReady) {
        ZoomMtg.preLoadWasm();
        ZoomMtg.prepareWebSDK();
        ZoomMtg.i18n.load('en-US');
        ZoomMtg.i18n.reload('en-US');

        ZoomMtg.init({
            leaveUrl: 'http://localhost:3000/',
            success: (success) => {
                _logger(success);

                ZoomMtg.join({
                    sdkKey: meeting.sdkKey,
                    signature: meeting.signature,
                    meetingNumber: meeting.meetingNumber,
                    passWord: meeting.passWord,
                    userName: meeting.userName,
                    zak: meeting.zak,
                    success: (success) => {
                        _logger(success);
                    },
                    error: (error) => {
                        _logger(error);
                    },
                });
            },
            error: (error) => {
                _logger(error);
            },
        });
    }
    return <></>;
}

export default ZoomStream;
