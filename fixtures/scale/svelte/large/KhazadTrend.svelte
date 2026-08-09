<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForKhazad(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="khazad-trend">
  <TrendSparkline />
  <p>{trendForKhazad(rows)}</p>
</div>

<style>
  .khazad-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
