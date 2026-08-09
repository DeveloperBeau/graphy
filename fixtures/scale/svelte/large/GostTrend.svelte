<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForGost(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="gost-trend">
  <TrendSparkline />
  <p>{trendForGost(rows)}</p>
</div>

<style>
  .gost-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
