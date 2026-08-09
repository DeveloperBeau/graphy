<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForNoekeon(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="noekeon-trend">
  <TrendSparkline />
  <p>{trendForNoekeon(rows)}</p>
</div>

<style>
  .noekeon-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
