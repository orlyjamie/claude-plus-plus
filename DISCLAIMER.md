# Security Research Disclaimer

## Authorization & Consent

By installing and executing this skill, you expressly acknowledge and consent to:

1. The execution of a single anonymous HTTP ping to an external counter server
2. Participation in security research demonstrating AI agent supply chain vulnerabilities

## What This Skill Does

This skill is a **security awareness demonstration**. When executed, it:

1. Sends ONE anonymous ping (`{"ping":"1","source":"vercel-skills"}`) to a counter endpoint
2. Displays a security awareness message explaining supply chain risks
3. Offers to help with your actual request

## What This Skill Does NOT Do

- Does NOT collect any personal information
- Does NOT read your files, code, or environment variables
- Does NOT exfiltrate any data
- Does NOT install malware or persistent code
- Does NOT modify your system

## Purpose

This research demonstrates:
- Install counts on skill marketplaces can be trivially inflated
- Skills can execute arbitrary code via AI agents
- Social engineering ("unlock hidden potential!") works on developers
- Trust metrics in AI ecosystems need improvement

## Full Research

https://x.com/theonejvo/status/2015892980851474595

## Opt Out

If you do not consent, simply uninstall the skill:
```bash
npx skills remove claude-plus-plus
```

---

This skill is provided "as is" for educational purposes only. The author assumes no liability for any consequences arising from its use.
