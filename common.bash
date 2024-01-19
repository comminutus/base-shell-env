this_dir="$(cd -- "$(dirname "$0")" &>/dev/null ; pwd -P )"
project="$this_dir/project.bash"

if [[ ! -e "$project" ]]; then
  echo "Error: Cannot find $project." >&2 
  echo "\tPlease create $project, containing 'container_name' and 'container_version' variables." >&2 
  exit 1
fi


. "$project"


if [[ ! -n "${container_name:-}" ]]; then
  echo "container_name must be set prior to running $0. Please set it inside $version_file." >&2
  exit 1
fi

if [[ ! -n "${container_version:-}" ]]; then
  echo "container_version must be set prior to running $0. Please set it inside $version_file." >&2
  exit 1
fi


versions=(latest "$container_version")

clean_version="${container_version%%-*}"
versions+=("$clean_version")

version_without_patch="${clean_version%.*}"
versions+=("$version_without_patch")

version_without_minor="${version_without_patch%.*}"
if [ "$version_without_minor" != "0" ]; then
  versions+=("$version_without_minor")
fi

# Remove duplicates
IFS=" " read -r -a versions <<< "$(tr ' ' '\n' <<< "${versions[@]}" | sort -u | tr '\n' ' ')"

tags=("${versions[@]/#/$container_name:}")
tag_args=("${tags[@]/#/-t }")