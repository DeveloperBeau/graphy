<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForChacha20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="chacha20-trend">
  <TrendSparkline />
  <p>{trendForChacha20(rows)}</p>
</div>

<style>
  .chacha20-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
