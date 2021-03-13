set -euo pipefail
script_dirpath="$(cd "$(dirname "${0}")" && pwd)"
root_dirpath="$(dirname "${script_dirpath}")"

# We can use relative syntax to specify kurtosis-core/kurtosis-libs in URLs because everything gets
# published to the same docs.kurtosistech.com domain, but when checking Markdown links we need to expand
# the full domain name
config_filepath="$(mktemp)"
cat << EOF > "${config_filepath}"
{
    "replacementPatterns": [
        { 
            "pattern": "^./kurtosis-core",
            "replacement": "https://docs.kurtosistech.com/kurtosis-core"
        },
        { 
            "pattern": "^./kurtosis-libs", 
            "replacement": "https://docs.kurtosistech.com/kurtosis-libs"
        }
    ]
}
EOF


# Inspired by https://github.com/open-telemetry/opentelemetry-collector/pull/1156/files/2244e61f4dd0378deffc00d939edf6f800687dcf
exit_code=0
for filepath in $(find "${root_dirpath}" -iname '*.md' | sort); do
    markdown-link-check --config "${config_filepath}" -qv "${filepath}" || exit_code=1
    # Wait to scan files so that we don't overload github with requests which may result in 429 responses
    sleep 2
done

exit "${exit_code}"
