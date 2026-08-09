<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForKlein(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="klein-trend">
  <TrendSparkline />
  <p>{trendForKlein(rows)}</p>
</div>

<style>
  .klein-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
