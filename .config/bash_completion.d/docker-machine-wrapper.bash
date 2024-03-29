# from https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-wrapper.bash

: ${DOCKER_MACHINE_WRAPPED:=true}

__docker_machine_wrapper () {
    if [[ "$1" == use ]]; then
        # Special use wrapper
        shift 1
        case "$1" in
            -h|--help|"")
                cat <<EOF
Usage: docker-machine use [OPTIONS] [arg...]

Evaluate the commands to set up the environment for the Docker client

Description:
   Argument is a machine name.

Options:

   --swarm	Display the Swarm config instead of the Docker daemon
   --unset, -u	Unset variables instead of setting them

EOF
                ;;
            *)
                eval "$(docker-machine env "$@")"
                echo "Active machine: ${DOCKER_MACHINE_NAME}"
                ;;
        esac
    else
        # Just call the actual docker-machine app
        command docker-machine "$@"
    fi
}

if [[ ${DOCKER_MACHINE_WRAPPED} = true ]]; then
    alias docker-machine=__docker_machine_wrapper
fi
