output "result" {
  value = merge(
    module.genesis.genesis_result,
  )
}
