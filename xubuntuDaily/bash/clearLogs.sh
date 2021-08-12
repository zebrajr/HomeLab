#!/bin/bash
journalctl --disk-usage
sudo journalctl --rotate
sudo journalctl --vacuum-time=5days
