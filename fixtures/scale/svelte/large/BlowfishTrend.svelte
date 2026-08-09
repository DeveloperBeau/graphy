<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForBlowfish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="blowfish-trend">
  <TrendSparkline />
  <p>{trendForBlowfish(rows)}</p>
</div>

<style>
  .blowfish-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
