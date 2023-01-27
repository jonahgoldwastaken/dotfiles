function ghcr
    gh repo create -s . -r origin --private --push $(basename "$PWD")
end
