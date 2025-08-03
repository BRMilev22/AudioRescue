# Security Policy

## Supported Versions

We take security seriously for AudioRescue. Currently supported versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in AudioRescue, please report it responsibly:

### How to Report

- **Email**: zvarazoku9@icloud.com
- **Subject**: [SECURITY] AudioRescue Vulnerability Report
- **LinkedIn**: https://www.linkedin.com/in/boris-milev-792546304/

### What to Include

Please include as much of the following information as possible:

- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact
- Suggested fix (if known)
- Your contact information for follow-up

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 7 days
- **Fix and Release**: Within 30 days (depending on severity)

### Security Considerations

AudioRescue requires administrative privileges to restart the CoreAudio daemon. This is necessary for the app's core functionality:

- Uses AppleScript with `administrator privileges` for secure elevation
- No network connections are made
- No personal data is collected or transmitted
- App sandbox is disabled only for admin privilege access
- All code is open source and auditable

### Responsible Disclosure

We request that you:

- Do not publicly disclose the vulnerability until we've had a chance to address it
- Do not access, modify, or delete data that doesn't belong to you
- Act in good faith and avoid privacy violations or service disruption

We appreciate your help in keeping AudioRescue secure for all users.

---

**Maintainer**: Boris Milev  
**Contact**: zvarazoku9@icloud.com  
**GitHub**: @BRMilev22