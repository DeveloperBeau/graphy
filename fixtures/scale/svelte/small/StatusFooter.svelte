<script>
  import RuleCounter from './RuleCounter.svelte';

  export let count = 0;
  export let preset = 'plain';

  function summary() {
    return count + ' lines through the ' + preset + ' preset';
  }
</script>

<footer class="status-footer">
  <span>{summary()}</span>
  <RuleCounter {preset} />
</footer>

<style>
  .status-footer {
    display: flex;
    justify-content: space-between;
    padding: 0.4rem 1rem;
    font-size: 0.8rem;
  }
</style>
